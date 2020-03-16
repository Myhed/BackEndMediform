"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function convertHexToBinary(hexKey) {
    return Array(hexKey.length / 2)
        .fill('')
        .map((_, index) => parseInt(hexKey[index] + hexKey[index + 1], 16));
}
exports.convertHexToBinary = convertHexToBinary;
//# sourceMappingURL=hexToBinary.js.map