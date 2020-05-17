import express = require('express')
import { Request,Response } from 'express'
import { CustomRequest } from '../interfaces/request'
import { verifyNewPatientInsertMiddleware } from '../middleware/patient'
import { httpLogger } from '../utils/logger'
import { mysqlPromiseQuery } from '../utils/mysql-promise'

const patientRouter: express.Router = express.Router()

patientRouter.use('/patient',verifyNewPatientInsertMiddleware)

patientRouter.get('/patients', async (req:CustomRequest,res: Response) => {
    const AllPatient = await mysqlPromiseQuery(req.db,'CALL P_getAllPatient()')
    res.status(200).send(JSON.stringify(AllPatient))
})

patientRouter.get('/patient/:idPatient', async (req:CustomRequest,res: Response) => {
    const { idPatient } = req.params
    const medecin = await mysqlPromiseQuery(req.db,`CALL P_getPatientById('${idPatient}')`)
    res.status(200).send(JSON.stringify(medecin))
})

patientRouter.post('/patient', async (req: CustomRequest, res: Response) => {
    const { nom,prenom,ville,profession,adresse } = req.body
    await mysqlPromiseQuery(req.db,`CALL P_insertMedecin('${nom}','${prenom}','${ville}','${profession}','${adresse}')`)
    res.status(200).send('resource created successfully')
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `With body ${JSON.stringify(req.body)}`)
})

export default patientRouter