// lib
import * as bodyParser from 'body-parser'
import * as cookieParser from 'cookie-parser'
import cors = require('cors')
import express = require('express')
import {authentification} from './middleware/authentification'
import { initLoggerMiddleware } from './middleware/logger'
import Categorie from './router/esport/categorie'
import Jeu from './router/esport/jeu'
import login from './router/esport/login'
import Style from './router/esport/style'
import Team from './router/esport/team'
import Tournoi from './router/esport/tournoi'
import User from './router/esport/user'
import { httpLogger, logger } from './utils/logger'
// Middleware global
const app: express.Application = express()

app.use((req, res, next) => {
  res.setHeader('X-Powered-By', 'HIA')
  next()
})

app.use(cors())
app.use(cookieParser.default())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(initLoggerMiddleware)
// app.use(authentification)
// ----- FIN Middleware global ------

// Router esport
app.use('/esport', User)
app.use('/esport', Jeu)
app.use('/esport', Team)
app.use('/esport', Tournoi)
app.use('/esport', Categorie)
app.use('/esport', Categorie)
app.use('/esport', Style)

// ------ Fin Router esport ------

// login esport/mediform
app.use('/esport', login)

// ------ Fin login esport/mediform ------

app.get('/',(req,res) => {
  res.send('Welcom to the apis HIA')
})

app.get(['/*','/esport/*','/mediform/*'],(req,res) => {
  res.status(404).send('Resource Not Found')
  httpLogger({method:req.method,originalUrl: req.url, statusCode: res.statusCode}).log('info', 'Ressource not found')
})

// Error middleware
app.use((err,req,res,next) => {
  res.status(err.code).send(err.message)
  next()
})
// ------ Fin Error middleware ------

const port = process.env.PORT || 7000

app.listen(port, () => {
  logger.log('info','Server started')
})
