import * as mysql from 'mysql'
import { mysqlPromisePrepare } from './mysql-promise'

export async function isUser(database: mysql.Pool, email: string) {
  const request = 'SELECT email FROM user WHERE email = ?'
  const verifyUser = (await mysqlPromisePrepare(database, request, [email])) || {}
  if (Object.values(verifyUser).length) {
    return 1
  }
  return 0
}
