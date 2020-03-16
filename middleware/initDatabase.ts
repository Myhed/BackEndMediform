import { NextFunction, Request, Response } from 'express'
import { CustomRequest } from '../interfaces/request'
import { initDatabase } from '../utils/initDatabase'

export function createConnection(req: CustomRequest, res: Response, next: NextFunction) {
  // const nameDatabase = req.baseUrl.substring(1, req.baseUrl.length)
  req.db = initDatabase('mediform')
  next()
}