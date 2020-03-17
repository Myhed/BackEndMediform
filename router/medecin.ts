import express = require('express')
import {Request,Response} from 'express'
import {CustomRequest} from '../interfaces/request'
import {mysqlPromiseQuery} from '../utils/mysql-promise'

const medecinRouter: express.Router = express.Router()


medecinRouter.get('/medecins',async (req:CustomRequest,res: Response) => {
    const AllMedecins = await mysqlPromiseQuery(req.db,'CALL P_getAllMedecins()')
    res.status(200).send(JSON.stringify(AllMedecins))
})

medecinRouter.get('/medecin/:id',(req:Request,res: Response) => {
    res.status(200).send('get medecins By id')
})

export default medecinRouter