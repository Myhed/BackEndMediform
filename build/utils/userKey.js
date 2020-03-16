"use strict";
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (Object.hasOwnProperty.call(mod, k)) result[k] = mod[k];
    result["default"] = mod;
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
const crypto = __importStar(require("crypto"));
const lodash_1 = require("lodash");
function createUserKey(data) {
    const payloads = lodash_1.values(data);
    const createHash = crypto.createHash('sha1');
    payloads.map((payload, index) => createHash.update(payload));
    return createHash.digest('hex');
}
exports.createUserKey = createUserKey;
//# sourceMappingURL=userKey.js.map