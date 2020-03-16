import { NextFunction,Request,Response } from 'express'
import {RequestWithCustomAttachement} from '../interfaces/request'
import {mysqlPromisePrepare} from '../utils/mysql-promise'

export async function verifyCategorieAlreadyExiste(req: RequestWithCustomAttachement,res: Response, next: NextFunction){
  const categorie = req.body.categorie
  const isExist = await mysqlPromisePrepare(req.db,'SELECT id FROM categorie WHERE name = ? ',[categorie])
  console.log(isExist)
  next()
}