import express = require('express')
import {Request,Response} from 'express'
import {CustomRequest} from '../interfaces/request'
import {mysqlPromiseQuery} from '../utils/mysql-promise'

const patientRouter: express.Router = express.Router()

patientRouter.get('/patients', async (req:CustomRequest,res: Response) => {
    const AllPatient = await mysqlPromiseQuery(req.db,'CALL P_getAllPatient()')
    res.status(200).send(JSON.stringify(AllPatient))
})

patientRouter.get('/patients/:id',(req:Request,res: Response) => {
    res.status(200).send('get patient By id')
})

export default patientRouter