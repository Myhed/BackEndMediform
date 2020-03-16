import * as mysql from 'mysql'
import {MysqlResult} from '../interfaces/mysql'
import {mysqlPromiseQuery} from './mysql-promise'

export async function getIdByField(db: mysql.Pool, nameField: string, nameFieldCompareTo: string, fieldValue: string){
    const result: MysqlResult = await mysqlPromiseQuery(db, `SELECT ${nameField} FROM jeux WHERE ${nameFieldCompareTo}=${fieldValue}`)
    return result
}