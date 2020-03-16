"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const logger_1 = require("../utils/logger");
function authentification(req, res, next) {
    logger_1.logger.log('info', `cookies ${req.cookies}`);
    next();
}
exports.authentification = authentification;
//# sourceMappingURL=authentification.js.map