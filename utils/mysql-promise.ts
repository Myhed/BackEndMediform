import * as mysql from 'mysql'

export async function mysqlPromiseQuery(database: mysql.Pool, request: string) {
  return new Promise((resolve, reject) => {
    database.query(request, (err, result) => {
      if (err) reject(err)
      resolve(result)
    })
  })
}

export async function mysqlPromisePrepare(database: mysql.Pool, request: string, preparedField: any[]) {
  return new Promise((resolve, reject) => {
    database.query(request, preparedField, (err, result) => {
      if (err) reject(err)
      resolve(result[0])
    })
  })
}
