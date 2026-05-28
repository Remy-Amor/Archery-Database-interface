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
