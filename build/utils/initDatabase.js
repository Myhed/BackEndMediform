"use strict";
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const mysql = __importStar(require("mysql"));
function initDatabase(nameDatabase) {
    const db = mysql.createPool({
        database: process.env.DB_DATABASE || nameDatabase,
        host: process.env.DB_HOST || 'localhost',
        password: process.env.DB_PASSWORD || 'root',
        user: process.env.DB_USER || 'root',
    });
    return db;
}
exports.initDatabase = initDatabase;
//# sourceMappingURL=initDatabase.js.map