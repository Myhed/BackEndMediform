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
const fakeBdd = __importStar(require("../../bdd.json"));
const esport_router_1 = __importDefault(require("./esport-router"));
const categorieRouter = esport_router_1.default;
categorieRouter.get('/categorie', (req, res) => {
    res.status(200);
    res.send(fakeBdd.categorie);
});
exports.default = categorieRouter;
//# sourceMappingURL=categorie.js.map