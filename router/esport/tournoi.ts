import * as fakeBdd from '../../bdd.json'
import esportRouter from './esport-router'

const tournoiRouter = esportRouter

tournoiRouter.get('/tournoi', (req, res) => {
  res.status(200)
  res.send(fakeBdd.jeux)
})

export default tournoiRouter
