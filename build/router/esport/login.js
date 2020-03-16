"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const esport_router_1 = __importDefault(require("./esport-router"));
const loginRouter = esport_router_1.default;
loginRouter.post('/login', (req, res) => {
    res.send('login');
});
exports.default = loginRouter;
//# sourceMappingURL=login.js.map