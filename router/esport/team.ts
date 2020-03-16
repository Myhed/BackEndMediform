import * as fakeBdd from '../../bdd.json'
import esportRouter from './esport-router'

const teamRouter = esportRouter

teamRouter.get('/team', (req, res) => {
  res.status(200)
  res.send(fakeBdd.team)
})

export default teamRouter
