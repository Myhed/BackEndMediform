import {NextFunction,Request, Response} from 'express'
import { logger } from '../utils/logger'

export function authentification(req: Request ,res: Response,next: NextFunction) {
    console.log(Object.keys(req.cookies).length)
    if(Object.keys(req.cookies).length === 0){
        next({message:'Unauthorized', code: 401})
    }else{
        console.log('oui : la')
        next()
    }
}