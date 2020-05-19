import {NextFunction,Request, Response} from 'express'
import { CustomRequest } from '../interfaces/request'
import { mysqlPromiseQuery } from '../utils/mysql-promise'

export function authentification(req: Request ,res: Response,next: NextFunction) {
}

export async function verifyMacClient(req: CustomRequest,res: Response, next: NextFunction){
    const authent = await mysqlPromiseQuery(req.db, `CALL P_verifyLoginByMac('${req.cookies.mac}','${req.cookies.sessionToken}')`);
    if(authent[0][0].auth === 0){
        const error = new Error('UnAuthorized invalide token')
        next({ message: error.message, code: 401 })
    }
    next();
}

export function isAuthent(req: Request,res: Response, next: NextFunction) {
    console.log(req.cookies.mac);
    if(typeof req.cookies.mac === "undefined" || typeof req.cookies.sessionToken === "undefined"){
        const error = new Error('UnAuthorized have no key pairs session')
        next({ message: error.message, code:401 }) 
    }else{
        next()
    }
}