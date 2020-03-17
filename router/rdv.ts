import express = require('express')
import {Request,Response} from 'express'
import {CustomRequest} from '../interfaces/request'
import {mysqlPromiseQuery} from '../utils/mysql-promise'

const rdvRouter: express.Router = express.Router()

rdvRouter.get('/patients', async (req:CustomRequest,res: Response) => {
    const AllPatient = await mysqlPromiseQuery(req.db,'CALL P_getAllPatientRDV()')
    res.status(200).send(JSON.stringify(AllPatient))
})

rdvRouter.get('/patients/:id',(req:Request,res: Response) => {
    res.status(200).send('get patient By id')
})

export default rdvRouter