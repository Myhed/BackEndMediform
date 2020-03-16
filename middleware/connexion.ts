import { NextFunction, Request, Response } from 'express'
import { RequestWithCustomAttachement } from '../interfaces/request'
import { initDatabase } from '../utils/initDatabase'

export function createConnection(req: RequestWithCustomAttachement, res: Response, next: NextFunction) {
  const nameDatabase = req.baseUrl.substring(1, req.baseUrl.length)
  req.db = initDatabase(nameDatabase)
  next()
}