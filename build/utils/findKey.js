"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hexToBinary_1 = require("./hexToBinary");
const xorKey_1 = require("./xorKey");
function findHashKeyUser(mac) {
    const x = hexToBinary_1.convertHexToBinary(mac);
    return xorKey_1.xorBinaryMacThroughKeyRotate(x);
}
exports.findHashKeyUser = findHashKeyUser;
//# sourceMappingURL=findKey.js.map