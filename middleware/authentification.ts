import {NextFunction,Request, Response} from 'express'
import { CustomRequest } from '../interfaces/request'
import { mysqlPromiseQuery } from '../utils/mysql-promise'

export function authentification(req: Request ,res: Response,next: NextFunction) {
}

export async function verifyMacClient(req: CustomRequest,res: Response, next: NextFunction){
    const authent = await mysqlPromiseQuery(req.db, `CALL P_verifyLoginByMac('${req.cookies.keyConnexion}')`);
    if(authent[0][0].auth === 0){
        const error = new Error('UnAuthorized invalide mac')
        next({ message: error.message, code: 401 })
    }
    next();
}

export function isAuthent(req: Request,res: Response, next: NextFunction) {
    console.log(req.cookies);
    if(typeof req.cookies.keyConnexion === "undefined"){
        const error = new Error('UnAuthorized you need to give keyConnexion')
        next({ message: error.message, code:401 })
    }else{
        next()
    }
}