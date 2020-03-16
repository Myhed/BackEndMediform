import { Request } from 'express'
import { Pool } from 'mysql'

export interface RequestWithCustomAttachement extends Request {
  hashMac: string
  db: Pool
}
