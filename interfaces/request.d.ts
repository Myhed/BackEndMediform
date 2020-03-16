import { Request } from 'express'
import { Pool } from 'mysql'

export interface CustomRequest extends Request {
  hashMac: string
  db: Pool
}
