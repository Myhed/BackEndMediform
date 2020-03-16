import * as fakeBdd from '../../bdd.json'
import esportRouter from './esport-router'

const styleRouter = esportRouter

styleRouter.get('/style', (req, res) => {
  res.status(200)
  res.send(fakeBdd.style)
})

export default styleRouter
