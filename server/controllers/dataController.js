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