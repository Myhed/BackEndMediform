import * as fakeBdd from '../../bdd.json'
import esportRouter from './esport-router'

const userRouter = esportRouter

userRouter.get('/users', (req, res) => {
  res.status(200)
  res.send(fakeBdd.users)
})

export default userRouter
