"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const logger_1 = require("../utils/logger");
function initLoggerMiddleware(req, res, next) {
    logger_1.logger.log('info', 'method loaded successfully');
    next();
}
exports.initLoggerMiddleware = initLoggerMiddleware;
//# sourceMappingURL=logger.js.map