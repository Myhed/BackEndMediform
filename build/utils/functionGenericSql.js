"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mysql_promise_1 = require("./mysql-promise");
async function getIdByField(db, nameField, nameFieldCompareTo, fieldValue) {
    const result = await mysql_promise_1.mysqlPromiseQuery(db, `SELECT ${nameField} FROM jeux WHERE ${nameFieldCompareTo}=${fieldValue}`);
    return result;
}
exports.getIdByField = getIdByField;
//# sourceMappingURL=functionGenericSql.js.map