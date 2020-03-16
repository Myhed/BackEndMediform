// lib
import * as bodyParser from 'body-parser'
import * as cookieParser from 'cookie-parser'
import cors = require('cors')
import express = require('express')
import {authentification} from './middleware/authentification'
import {createConnection} from './middleware/initDatabase'
import { initLoggerMiddleware } from './middleware/logger'
import { patientRouter,medecinRouter } from './router'
import { httpLogger, logger } from './utils/logger'
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
app.use('/mediform',patientRouter)
app.use('/mediform',medecinRouter)
// ------ Fin Router esport ------

// login mediform
// app.use('/esport', login)

// ------ Fin login mediform ------

app.get('/',(req,res) => {
  res.send('Welcom to the apis HIA')
})

app.get(['/*','/mediform/*'],(req,res) => {
  res.status(404).send('Resource Not Found')
  httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', 'Ressource not found')
})

// Error middleware
app.use((err,req,res,next) => {
  res.status(err.code).send(err.message)
  next()
})
// ------ Fin Error middleware ------

const port = process.env.PORT || 6000

app.listen(port, () => {
  logger.log('info',`Server started ${port}`)
})
