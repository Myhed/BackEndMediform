// lib
import * as bodyParser from 'body-parser'
import * as cookieParser from 'cookie-parser'
import cors = require('cors')
import express = require('express')
import { verifyMacClient, isAuthent } from './middleware/authentification'
// import { CustomRequest } from './interfaces/request'
// import { Request, Response, NextFunction } from 'express'
import { createConnection } from './middleware/initDatabase'
import { initLoggerMiddleware } from './middleware/logger'
import { medecinRouter, patientRouter, rdvRouter, rootRooter } from './router'
import { httpLogger, logger } from './utils/logger'
// import { mysqlPromiseQuery } from './utils/mysql-promise'
// Middleware global
const app: express.Application = express()

app.use((req, res, next) => {
  res.setHeader('X-Powered-By', 'HIA')
  next()
})
app.use(createConnection)
app.use(cors())
app.use(cookieParser.default())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(initLoggerMiddleware)


// app.use(authentification)
// ----- FIN Middleware global ------

// Router Mediform
app.use('/mediform',isAuthent,verifyMacClient,patientRouter)
app.use('/mediform',isAuthent,verifyMacClient,medecinRouter)
app.use('/mediform',isAuthent,verifyMacClient,rdvRouter)
app.use('/',rootRooter)
// ------ Fin Router esport ------

// login mediform 
// ------ Fin login mediform ------


app.get(['/*','/mediform/*'],(req,res) => {
  res.status(404).send('Resource Not Found')
  httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', 'Ressource not found')
})

// Error middleware
app.use((err,req,res,next) => {
  res.status(err.code).send(err)
  httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('error',err.message)
  next()
})
// ------ Fin Error middleware ------

const port = process.env.PORT || 8000

app.listen(port, () => {
  logger.log('info',`Server started ${port}`)
})
