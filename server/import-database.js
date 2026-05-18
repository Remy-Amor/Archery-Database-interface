import { join, dirname } from 'path';
import { readFileSync, existsSync } from 'fs';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';
import mysql from 'mysql2/promise';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config({ path: join(__dirname, '.env') });

async function importDatabase() {
  let connection;
  
  try {
    const dbName = process.env.DB_NAME || 'archery_db';

    // 1. Connect to MariaDB cloud WITHOUT specifying a default database
    console.log('🔌 Connecting to MariaDB Cloud...');
    connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT) || 3306,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      multipleStatements: true, // Allows running CREATE DATABASE and USE together
      ssl: {
        rejectUnauthorized: false // MariaDB cloud requires SSL
      }
    });

    console.log('✅ Connected to MariaDB Cloud');

    // 2. Create the database if it doesn't exist, and switch to it
    console.log(`📁 Creating database '${dbName}' if it doesn't exist...`);
    await connection.query(`CREATE DATABASE IF NOT EXISTS \`${dbName}\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`);
    await connection.query(`USE \`${dbName}\``);
    console.log(`✅ Now using database: ${dbName}`);

    // 3. Read and execute your SQL file
    const sqlStructurePath = join(__dirname, 'db_structure.sql');
    const sqlQueriesPath = join(__dirname, 'db_queries.sql');
    
    if (!existsSync(sqlStructurePath)) {
      throw new Error(`SQL file not found: ${sqlStructurePath}`);
    }

    if (!existsSync(sqlQueriesPath)) {
      throw new Error(`SQL file not found: ${sqlQueriesPath}`);
    }
    
    const sqlStructureContent = readFileSync(sqlStructurePath, 'utf8');
    const sqlQueriesContent = readFileSync(sqlQueriesPath, 'utf8');
    console.log(`📄 Read SQL file: ${sqlStructurePath}`);
    console.log(`📏 File size: ${(sqlStructureContent.length / 1024).toFixed(2)} KB`);

    console.log('⚡ Executing SQL...');
    await connection.query(sqlStructureContent);
    await connection.query(sqlQueriesContent);
    
    console.log('✅ Database imported successfully!');

    // 4. Verify the tables were created
    const [tables] = await connection.query('SHOW TABLES');
    const archers = await connection.query('SELECT * FROM archers');
    console.log('📋 Tables created:', tables.map(t => Object.values(t)[0]));
    console.log(archers);

  } catch (error) {
    console.error('❌ Import failed:', error.message);
    process.exit(1);
  } finally {
    if (connection) {
      await connection.end();
      console.log('👋 Connection closed');
    }
  }
}

importDatabase();