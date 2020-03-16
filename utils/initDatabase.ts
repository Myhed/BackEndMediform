import * as mysql from 'mysql'
export function initDatabase(nameDatabase: string) {
  const db = mysql.createPool({
    database: process.env.DB_DATABASE || nameDatabase,
    host: process.env.DB_HOST || 'localhost',
    password: process.env.DB_PASSWORD || 'root',
    user: process.env.DB_USER || 'root',
  })
  return db
}
