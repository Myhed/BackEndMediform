"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mysql_promise_1 = require("./mysql-promise");
async function getIdByField(db, idName, field, fieldValue) {
    const result = await mysql_promise_1.mysqlPromiseQuery(db, `SELECT ${idName} FROM jeux WHERE ${field}=${fieldValue}`);
    return result;
}
exports.getIdByField = getIdByField;
//# sourceMappingURL=functionGeneric.js.map