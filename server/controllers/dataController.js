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
    const data = [req.body.archerID, req.body.division];
    const sql = 'UPDATE archers SET defaultDivision = ? WHERE archeryAustraliaID = ?';
    pool.query(sql, data, (err, results) => {
      if(err) throw err;
      console.log("Rows affected: ", results.affectedRows);
    })
    
  } catch (err){
    res.status(500).json({error: err.message});
  }
}
