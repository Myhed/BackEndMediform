"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const logger_1 = require("../../utils/logger");
const mysql_promise_1 = require("../../utils/mysql-promise");
const esport_router_1 = __importDefault(require("./esport-router"));
const jeuRouter = esport_router_1.default;
jeuRouter.get('/jeux', async (req, res) => {
    const result = await mysql_promise_1.mysqlPromiseQuery(req.db, 'SELECT a.name AS `nameGame`,a.image_url,b.name AS `nameCategorie` FROM `jeux` AS `a` INNER JOIN `reference` AS `c` ON `a`.`id_jeu` = `c`.id_jeu JOIN `categorie` AS `b` ON  b.id_categorie = c.id_categorie');
    logger_1.httpLogger({ method: req.method, originalUrl: req.originalUrl, statusCode: res.statusCode }).log('debug', `query result: ${JSON.stringify(result)}`);
    res.status(200).send(result);
});
jeuRouter.post('/jeux', async (req, res) => {
    // tslint:disable-next-line:quotemark
    const result = await mysql_promise_1.mysqlPromiseQuery(req.db, `INSERT INTO jeux VALUES(null,'${req.body.name}','${req.body.imgUrl}')`);
    logger_1.httpLogger({ method: req.method, originalUrl: req.originalUrl, statusCode: res.statusCode }).log('debug', req.body);
    // @ToDo insert id_jeu with his categorie
    // res.send(result)
});
exports.default = jeuRouter;
//# sourceMappingURL=jeu.js.map