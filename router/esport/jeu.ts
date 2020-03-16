import { Response } from 'express'
import {MysqlResult} from '../../interfaces/mysql'
import { RequestWithCustomAttachement } from '../../interfaces/request'
import { authentification } from '../../middleware/authentification'
import { httpLogger,logger } from '../../utils/logger'
import { mysqlPromisePrepare, mysqlPromiseQuery } from '../../utils/mysql-promise'
import esportRouter from './esport-router'
const jeuRouter = esportRouter

jeuRouter.get('/jeux', async (req: RequestWithCustomAttachement, res: Response) => {
  const result = await mysqlPromiseQuery(
    req.db,'CALL getJeuxWithHisCategorie()')
  httpLogger({method: req.method,originalUrl: req.originalUrl, statusCode: res.statusCode}).log('debug',`query result: ${JSON.stringify(result)}`)
  res.status(200).send(result)
})

jeuRouter.post('/jeux', async (req: RequestWithCustomAttachement, res: Response) => {
    // tslint:disable-next-line:quotemark
    const name = req.body.name
    const imgUrl = req.body.imgUrl
    const nameCategorie = req.body.nameCategorie
    const result: MysqlResult = await mysqlPromiseQuery(req.db,`CALL insertJeux('${name}','${imgUrl}',@lastIdJeu)`)
    httpLogger({method: req.method, originalUrl: req.originalUrl, statusCode: res.statusCode}).log('debug',req.body)
    // @ToDo insert id_jeu with his categorie
    console.log('result:',result)
    const v: MysqlResult = await mysqlPromiseQuery(req.db,`CALL insertCategorieJeu('${nameCategorie}')`)
    console.log('v: ', v)
    // res.send(result)
})

export default jeuRouter