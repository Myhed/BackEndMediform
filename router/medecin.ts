import express = require('express')
import { Request,Response } from 'express'
import { CustomRequest } from '../interfaces/request'
import { verifyNewMedecinInsertMiddleware } from '../middleware/medecin'
import { httpLogger } from '../utils/logger'
import { mysqlPromiseQuery } from '../utils/mysql-promise'

const medecinRouter: express.Router = express.Router()
// --- Middleware POST
medecinRouter.use('/medecin', verifyNewMedecinInsertMiddleware)

// --- Middleware GET
// --- Middleware GLOBAL
medecinRouter.get('/medecins',async (req:CustomRequest,res: Response) => {
    const AllMedecins = await mysqlPromiseQuery(req.db,'CALL P_getAllMedecins()')
    res.status(200).send(JSON.stringify(AllMedecins))
})

medecinRouter.get('/medecin/:idMedecin', async (req:CustomRequest,res: Response) => {
    const {idMedecin} = req.params
    const medecin = await mysqlPromiseQuery(req.db,`CALL P_getMedecinById('${idMedecin}')`)
    res.status(200).send(JSON.stringify(medecin))
})

medecinRouter.post('/medecin', async (req: CustomRequest, res: Response) => {
    const { nom,prenom,ville,profession,adresse, tel, email } = req.body
    await mysqlPromiseQuery(req.db,`CALL P_insertMedecin('${nom}','${prenom}','${adresse}','${tel}','${email}','${ville}','${profession}')`)
    res.status(200).send('resource created successfully')
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `With body ${JSON.stringify(req.body)}`)
})

export default medecinRouter