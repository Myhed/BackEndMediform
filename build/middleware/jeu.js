"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mysql_promise_1 = require("../utils/mysql-promise");
async function verifyCategorieAlreadyExiste(req, res, next) {
    const categorie = req.body.categorie;
    const isExist = await mysql_promise_1.mysqlPromisePrepare(req.db, 'SELECT id FROM categorie WHERE name = ? ', [categorie]);
    console.log(isExist);
    next();
}
exports.verifyCategorieAlreadyExiste = verifyCategorieAlreadyExiste;
//# sourceMappingURL=jeu.js.map