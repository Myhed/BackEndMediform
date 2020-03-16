"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function xorBinaryMacThroughKeyRotate(binaryMacs) {
    let indexRotate = 0;
    const indexKeyRotate = Array(5)
        .fill('')
        .map((_, index) => index + 1);
    const macHexKey = binaryMacs
        .map(chunkBinaryMac => {
        indexRotate = indexRotate % indexKeyRotate.length;
        // tslint:disable-next-line: no-bitwise
        const macStr = (chunkBinaryMac ^ indexKeyRotate[indexRotate]).toString(16);
        // tslint:disable-next-line: no-increment-decrement
        indexRotate++;
        return macStr;
    })
        .join('');
    return macHexKey;
}
exports.xorBinaryMacThroughKeyRotate = xorBinaryMacThroughKeyRotate;
//# sourceMappingURL=xorKey.js.map