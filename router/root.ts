import * as express from 'express'
import { Request, Response, NextFunction } from 'express'
import { CustomRequest } from '../interfaces/request'
import { httpLogger } from '../utils/logger'
import { mysqlPromiseQuery } from '../utils/mysql-promise'

const rootRouter: express.Router = express.Router();

rootRouter.get('/',(req,res) => {
    res.send('Welcom to the apis HIA')
})

rootRouter.post('/login', async ( req: CustomRequest, res: Response, next: NextFunction ) => {
    const { email } = req.body;
    const request = await mysqlPromiseQuery(req.db,`CALL P_loginPatient('${email}')`)
    const mac = request[0][0]['macPatient'].toString()
    const token = request[0][0]['tokenPatient'].toString()
    
    httpLogger({ method:req.method,originalUrl: req.url, statusCode: res.statusCode })
    .log('info',`mac given ${ mac }, length ${mac.length} : token given ${ token }, length ${ token.length } `);

    res.cookie('mac', mac, {
        httpOnly: true,
        maxAge: 123456789,
        domain: 'localhost'
    })
    res.cookie('sessionToken', token, {
        httpOnly: true,
        maxAge: 123456789,
        domain: 'localhost'
    })
    res.status(200).send('you are now connected')
});



export default rootRouter;