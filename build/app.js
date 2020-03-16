"use strict";
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// lib
const bodyParser = __importStar(require("body-parser"));
const cookieParser = __importStar(require("cookie-parser"));
const cors = require("cors");
const express = require("express");
const authentification_1 = require("./middleware/authentification");
const logger_1 = require("./middleware/logger");
const categorie_1 = __importDefault(require("./router/esport/categorie"));
const jeu_1 = __importDefault(require("./router/esport/jeu"));
const login_1 = __importDefault(require("./router/esport/login"));
const style_1 = __importDefault(require("./router/esport/style"));
const team_1 = __importDefault(require("./router/esport/team"));
const tournoi_1 = __importDefault(require("./router/esport/tournoi"));
const user_1 = __importDefault(require("./router/esport/user"));
const logger_2 = require("./utils/logger");
// Middleware global
const app = express();
app.use((req, res, next) => {
    res.setHeader('X-Powered-By', 'HIA');
    next();
});
app.use(cors());
app.use(cookieParser.default());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(logger_1.initLoggerMiddleware);
app.use(authentification_1.authentification);
// ----- FIN Middleware global ------
// Router esport
app.use('/esport', user_1.default);
app.use('/esport', jeu_1.default);
app.use('/esport', team_1.default);
app.use('/esport', tournoi_1.default);
app.use('/esport', categorie_1.default);
app.use('/esport', categorie_1.default);
app.use('/esport', style_1.default);
// ------ Fin Router esport ------
// login esport/mediform
app.use('/esport', login_1.default);
// ------ Fin login esport/mediform ------
app.get('/', (req, res) => {
    res.send('Welcom to the apis HIA');
});
app.get(['/*', '/esport/*', '/mediform/*'], (req, res) => {
    res.status(404).send('Resource Not Found');
    logger_2.httpLogger({ method: req.method, originalUrl: req.url, statusCode: res.statusCode }).log('info', 'Ressource not found');
});
// Error middleware
app.use((err, req, res, next) => {
    res.status(err.code).send(err.message);
    next();
});
// ------ Fin Error middleware ------
const port = process.env.PORT || 7000;
app.listen(port, () => {
    logger_2.logger.log('info', 'Server started');
});
//# sourceMappingURL=app.js.map