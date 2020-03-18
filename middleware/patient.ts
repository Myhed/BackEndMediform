import { NextFunction, Request, Response } from 'express'

export function verifyNewPatientInsertMiddleware(req: Request, res: Response, next: NextFunction) {
  const { nom, prenom, ville, tel, adresse } = req.body
  if(req.method !== 'POST'){
    return next('route')
  }
  if (
    typeof nom === 'undefined' ||
    typeof prenom === 'undefined' ||
    typeof ville === 'undefined' ||
    typeof tel === 'undefined' ||
    typeof adresse === 'undefined'
  ) {
    next({ code: 400, message: new Error('BAD REQUEST make you sure you give all parameter asked').message })
  } else {
    next()
  }
}
