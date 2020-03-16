"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const connexion_1 = require("../../middleware/connexion");
const router_1 = __importDefault(require("../router"));
const esportRouter = router_1.default;
esportRouter.use(connexion_1.createConnection);
exports.default = esportRouter;
//# sourceMappingURL=esport-router.js.map