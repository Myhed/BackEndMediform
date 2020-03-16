"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function resourceNotFound404(err, req, res, next) {
    res.status(404).send('resource not found');
}
exports.resourceNotFound404 = resourceNotFound404;
function badRequest400() {
    return { message: 'Bad Request', code: 400 };
}
exports.badRequest400 = badRequest400;
function unAuthorized401() {
    return { message: 'Unauthorized', code: 401 };
}
exports.unAuthorized401 = unAuthorized401;
function serviceUnavailable503(err, req, res, next) {
    return { message: 'Service Unavailable', code: 503 };
}
exports.serviceUnavailable503 = serviceUnavailable503;
function internalServerError500(err, req, res, next) {
    res.status(500).send('Internal Serveur Error');
    return { message: 'Internal Serveur Error', code: 500 };
}
exports.internalServerError500 = internalServerError500;
function featureNotImplemented501(err, req, res, next) {
    res.status(501).send('Feature Not Implemented');
}
exports.featureNotImplemented501 = featureNotImplemented501;
//# sourceMappingURL=error.js.map