import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
// getting relative directory path to work
const __dirname = path.dirname(fileURLToPath(import.meta.url));
import 'dotenv/config';

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