// import { NextFunction, Request, Response } from 'express'
// import { RequestWithCustomAttachement } from '../interfaces/request'
// import { convertHexToBinary } from '../utils/hexToBinary'
// import { isUser } from '../utils/userConnexion'
// import { createUserKey } from '../utils/userKey'
// import { xorBinaryMacThroughKeyRotate } from '../utils/xorKey'
// import {badRequest400, unAuthorized401} from './error'

// export async function verifyUserAuthentication(req: RequestWithCustomAttachement, res: Response, next: NextFunction) {
//   if (!Object.values(req.body).length) {
//     next(unAuthorized401)
//   }
//   const result = await isUser(req.db, req.body.email)
//   next()
// }

// export function createSessionUser(req: RequestWithCustomAttachement, res: Response, next: NextFunction): void {
//   if(typeof req.body.email === 'undefined'){
//     next(badRequest400())
//   }else{
//     const hash = createUserKey(req.body)
//     // Insert into database Hash
//     const binaryHash = convertHexToBinary(hash)
//     const xorHashMac = xorBinaryMacThroughKeyRotate(binaryHash)
//     req.hashMac = xorHashMac
//     next()
//   }
// }
