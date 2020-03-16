import { Request, Response } from 'express'
import esportRouter from './esport-router'

const loginRouter = esportRouter

loginRouter.post('/login',(req, res) => {
  res.send('login')
})

export default loginRouter
