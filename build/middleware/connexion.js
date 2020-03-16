"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const initDatabase_1 = require("../utils/initDatabase");
function createConnection(req, res, next) {
    const nameDatabase = req.baseUrl.substring(1, req.baseUrl.length);
    req.db = initDatabase_1.initDatabase(nameDatabase);
    next();
}
exports.createConnection = createConnection;
//# sourceMappingURL=connexion.js.map