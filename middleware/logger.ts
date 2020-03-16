import { NextFunction,Request,Response } from 'express'
import { logger } from '../utils/logger'
export function initLoggerMiddleware(req: Request ,res: Response,next: NextFunction) {
  logger.log('info','method loaded successfully')
  next()
}