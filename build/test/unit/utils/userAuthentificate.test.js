"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const userAuthentification_1 = require("../../../utils/userAuthentification");
describe('Authenticate', () => {
    it('should create token', () => {
        // Given
        const expectedTokenLength = 32;
        // When
        const token = userAuthentification_1.createToken();
        // Then
        expect(typeof token).toBe('string');
        expect(token.length).toEqual(expectedTokenLength);
    });
    it('should create mac from token', () => {
        // Given
        const token = userAuthentification_1.createToken();
        // When
        const mac = userAuthentification_1.createMacFromToken(token);
        // Then
        expect(typeof mac).toBe('string');
    });
    it('should xor and rexor mac', () => {
        // Given
        const token = userAuthentification_1.createToken();
        const mac = userAuthentification_1.createMacFromToken(token);
        // When
        const tokenX = userAuthentification_1.verifyTokenWithMac(mac, token);
        // Then
        expect(tokenX).toEqual(true);
    });
});
// // create K
// var k = [];
// for(var i=0; i < 16; i++) {
//     k[i] = Math.floor((Math.random() * (255 - 0)));
// }
// console.log(k);
// // create MAC from k
// var mac = [],
//     SALT = 42;
// for(var j=0; j < k.length; j++){
//     mac[j] = k[j] ^ SALT;
// }
// console.log("mac:", mac);
// verify
// for(var j=0; j < k.length; j++){
//     if ((mac[j] ^ SALT) !== k[j]) {
//         console.error("ivalid value at %d : %d/%d, expected: %d", j, mac[j], mac[j] ^ SALT, k[j]);
//         break;
//     }
// }
// // 1
// var hex = "7FAB",
//     A, B,
// 	expected = parseInt(hex, 16);
// A = (expected & 0x00FF);
// B = (expected & 0xFF00) >> 8;
// console.log("A : %d : %s", A, A.toString(16).toUpperCase());
// console.log("B : %d : %s", B, B.toString(16).toUpperCase());
// console.log("B + A : %d : %s", (B << 8 | A), (B << 8 | A).toString(16).toUpperCase());
//# sourceMappingURL=userAuthentificate.test.js.map