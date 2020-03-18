import { NextFunction, Request, Response } from 'express'
import { CustomRequest } from '../interfaces/request'
import { initDatabase } from '../utils/initDatabase'

export function createConnection(req: CustomRequest, res: Response, next: NextFunction) {
  req.db = initDatabase('mediform')
  next()
}