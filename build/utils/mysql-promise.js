"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
async function mysqlPromiseQuery(database, request) {
    return new Promise((resolve, reject) => {
        database.query(request, (err, result) => {
            if (err)
                reject(err);
            resolve(result);
        });
    });
}
exports.mysqlPromiseQuery = mysqlPromiseQuery;
async function mysqlPromisePrepare(database, request, preparedField) {
    return new Promise((resolve, reject) => {
        database.query(request, preparedField, (err, result) => {
            if (err)
                reject(err);
            resolve(result[0]);
        });
    });
}
exports.mysqlPromisePrepare = mysqlPromisePrepare;
//# sourceMappingURL=mysql-promise.js.map