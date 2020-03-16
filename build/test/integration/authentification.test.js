"use strict";
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const rp = __importStar(require("request-promise"));
describe('Authentificate', () => {
    it('should reject user when he doesnt have token', async () => {
        const result = await rp.default('http://127.0.0.1:7000/esport/jeux/dqdzdqzd');
        expect(result).toBe('Unauthorized');
    });
});
//# sourceMappingURL=authentification.test.js.map