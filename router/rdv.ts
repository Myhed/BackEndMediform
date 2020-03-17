import express = require('express')
import { Request,Response } from 'express'
import { CustomRequest } from '../interfaces/request'
import { mysqlPromiseQuery } from '../utils/mysql-promise'
import { httpLogger } from '../utils/logger'
const rdvRouter: express.Router = express.Router()

rdvRouter.get('/rdv', async (req:CustomRequest,res: Response) => {
    const rdv = await mysqlPromiseQuery(req.db,'CALL P_getAllRdv()')
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `Resource with param ${JSON.stringify(req.params)}`)
    res.status(200).send(JSON.stringify(rdv))
})

rdvRouter.get('/rdv/today', async (req:CustomRequest,res: Response) => {
    const rdvToday = await mysqlPromiseQuery(req.db,'CALL P_getAllRdvToday()')
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `Resource with param ${JSON.stringify(req.params)}`)
    res.status(200).send(JSON.stringify(rdvToday))
})

rdvRouter.get('/rdv/:patientId',(req:Request,res: Response) => {
    res.status(200).send('get patient By id')
})

rdvRouter.get('/rdv/medecin/:idMedecin', async (req:CustomRequest,res: Response) => {
    const { idMedecin } = req.params;
    const rdvMedecin = await mysqlPromiseQuery(req.db,`CALL P_getRdvMedecinById(${idMedecin})`)
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `Resource with param ${JSON.stringify(req.params)}`)
    res.status(200).send(rdvMedecin)
})

rdvRouter.get('/rdv/today/medecin/:idMedecin', async (req:CustomRequest,res: Response) => {
    const { idMedecin } = req.params;
    const rdvMedecinToday = await mysqlPromiseQuery(req.db,`CALL P_getRdvMedecinTodayById(${idMedecin})`)
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `Resource with param ${JSON.stringify(req.params)}`)
    res.status(200).send(rdvMedecinToday)
})

rdvRouter.get('/rdv/patient/:idPatient', async (req:CustomRequest,res: Response) => {
    const { idPatient } = req.params;
    const rdvPatient = await mysqlPromiseQuery(req.db,`CALL P_getRdvPatientById(${idPatient})`)
    httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', `Resource with param ${JSON.stringify(req.params)}`)
    res.status(200).send(rdvPatient)
})

export default rdvRouter