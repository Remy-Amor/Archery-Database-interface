

import 'dotenv/config';
import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
// getting relative directory path to work
const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Debug: log what's being read
console.log('DB Config:', {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD ? '***' : 'NOT SET',
  database: process.env.DB_NAME,
});

import router from './routes/api.js';

const app = express();
const PORT = process.env.PORT || 3001;

app.use(express.json());
app.use('/api', router);

// Serve the built Vue app from ../client/dist
app.use(express.static(path.join(__dirname, '../client/dist')));
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../client/dist/index.html'));
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});