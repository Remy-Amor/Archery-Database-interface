import {pool} from '../config/db.js';

export const getAllArchers = async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM archers');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getAllRounds = async (req, res) => {
  try {
    const [rounds] = await pool.query('SELECT * FROM rounds');
    res.json(rounds);
  } catch (err){
    res.status(500).json({error: err.message});
  }
}

export const setArcherDivision = async (req, res) => {
  try {
    const { id } = req.params; 
    const { division } = req.body;  
    const sql = 'UPDATE archers SET defaultDivision = ? WHERE archeryAustraliaID = ?';
    const [result] = await pool.query(sql, [division, id], (err, results) => {
      if(err) throw err;
      console.log("Rows affected: ", results.affectedRows);
    })

    // Fetch and return the updated archer
    const [updated] = await pool.query(
      'SELECT * FROM archers WHERE archeryAustraliaID = ?',
      [id]
    );
    
    res.json(updated[0]);
  } catch (err){
    res.status(500).json({error: err.message});
  }
}

// GET all ranges for a given round, ordered by sequence
export const getRoundRanges = async (req, res) => {
  try {
    const { roundID } = req.params;
    const [rows] = await pool.query(
      `SELECT rr.rangeSequence, r.rangeID, r.distance, r.endCount
       FROM round_ranges rr
       JOIN \`ranges\` r ON rr.rangeID = r.rangeID
       WHERE rr.roundID = ?
       ORDER BY rr.rangeSequence`,
      [roundID]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// POST submit a full recorded round with ends
export const submitRecordedRound = async (req, res) => {
  const conn = await pool.getConnection();
  try {
    const { archerID, roundID, ends } = req.body;

    // Validate input
    if (!archerID || !roundID || !Array.isArray(ends) || ends.length === 0) {
      return res.status(400).json({ error: 'Invalid request body' });
    }

    await conn.beginTransaction();

    // 1. Compute total score and create recorded round
    let totalScore = 0;
    ends.forEach(rangeGroup => {
      rangeGroup.scores.forEach(end => {
        // end is an array of 6 strings like ["M","9","X","8","7","6"]
        // convert to numeric values: M=0, X=10
        end.forEach(val => {
          if (val === 'X' || val === '10') totalScore += 10;
          else if (val !== 'M' && !isNaN(val)) totalScore += parseInt(val);
          // else M or invalid = 0
        });
      });
    });

    const dateCompleted = new Date();
    const [recordedResult] = await conn.query(
      `INSERT INTO individual_recorded_rounds (archerID, roundID, dateCompleted, totalScore)
       VALUES (?, ?, ?, ?)`,
      [archerID, roundID, dateCompleted, totalScore]
    );
    const recordedRoundID = recordedResult.insertId;

    // 2. Process each range group
    for (const rangeGroup of ends) {
      const { rangeID, rangeSequence, scores } = rangeGroup;

      // Create individual_round_ranges entry
      const [rangeResult] = await conn.query(
        `INSERT INTO individual_round_ranges (recordedRoundID, rangeID, rangePositionNumber)
         VALUES (?, ?, ?)`,
        [recordedRoundID, rangeID, rangeSequence]
      );
      const individualRecordedRangeID = rangeResult.insertId;

      // 3. Process each end in this range
      for (let endIdx = 0; endIdx < scores.length; endIdx++) {
        const endScores = scores[endIdx];   // array of 6 values
        // Convert arrow strings to DB format: arrow1..arrow6
        const arrows = {};
        let bullseyeCount = 0;
        endScores.forEach((val, arrowIdx) => {
          const colName = `arrow${arrowIdx + 1}`;
          if (val === 'M' || val === 'm') {
            arrows[colName] = 0;
          } else if (val === 'X' || val === 'x') {
            arrows[colName] = 10;
            bullseyeCount++;
          } else {
            const num = parseInt(val);
            arrows[colName] = isNaN(num) ? 0 : num;
          }
        });

        // Insert end
        const [endResult] = await conn.query(
          `INSERT INTO \`ends\` (arrow1, arrow2, arrow3, arrow4, arrow5, arrow6, bullseyeCount)
           VALUES (?, ?, ?, ?, ?, ?, ?)`,
          [arrows.arrow1, arrows.arrow2, arrows.arrow3, arrows.arrow4, arrows.arrow5, arrows.arrow6, bullseyeCount]
        );
        const endID = endResult.insertId;

        // Link end to range
        await conn.query(
          `INSERT INTO individual_range_ends (individualRecordedRangeID, endID, endPositionNumber, rangeID)
           VALUES (?, ?, ?, ?)`,
          [individualRecordedRangeID, endID, endIdx + 1, rangeID]
        );
      }
    }

    await conn.commit();
    res.status(201).json({
      message: 'Recorded round saved successfully',
      recordedRoundID,
      totalScore
    });
  } catch (err) {
    await conn.rollback();
    console.error('Submit error:', err);
    res.status(500).json({ error: err.message });
  } finally {
    conn.release();
  }
};
