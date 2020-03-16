"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const mysql_promise_1 = require("./mysql-promise");
async function isUser(database, email) {
    const request = 'SELECT email FROM user WHERE email = ?';
    const verifyUser = (await mysql_promise_1.mysqlPromisePrepare(database, request, [email])) || {};
    if (Object.values(verifyUser).length) {
        return 1;
    }
    return 0;
}
exports.isUser = isUser;
//# sourceMappingURL=userConnexion.js.map