import * as fakeBdd from '../../bdd.json'
import esportRouter from './esport-router'

const categorieRouter = esportRouter
categorieRouter.get('/categorie', (req, res) => {
  res.status(200)
  res.send(fakeBdd.categorie)
})
export default categorieRouter
