import {ErrorRequestHandler,NextFunction,Request,Response} from 'express'
export function resourceNotFound404(err: ErrorRequestHandler ,req: Request ,res: Response,next: NextFunction){
    res.status(404).send('resource not found')
}

export function badRequest400(){
    return {message: 'Bad Request',code: 400}
}

export function unAuthorized401(){
    return {message: 'Unauthorized',code: 401}
}

export function serviceUnavailable503(err: ErrorRequestHandler ,req: Request ,res: Response,next: NextFunction){
    return {message: 'Service Unavailable',code: 503}
}

export function internalServerError500(err: ErrorRequestHandler ,req: Request ,res: Response,next: NextFunction){
    res.status(500).send('Internal Serveur Error')
    return {message: 'Internal Serveur Error',code: 500}
}

export function featureNotImplemented501(err: ErrorRequestHandler ,req: Request ,res: Response,next: NextFunction){
    res.status(501).send('Feature Not Implemented')
}