import { createConnection } from '../../middleware/connexion'
import generiqueRouter from '../router'

const esportRouter = generiqueRouter

esportRouter.use(createConnection)

export default esportRouter
