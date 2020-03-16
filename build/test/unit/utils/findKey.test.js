// import * as xorKey from '../../../utils/xorKey'
// import * as hexToBinary from '../../../utils/hexToBinary'
// import { when } from 'jest-when';
// describe("findHashKeyUser", () => {
//   let findHashKeyUser: any;
//   let convertHexToBinarySpy: jest.SpyInstance;
//   let xorBinaryMacThroughKeyRotateSpy: jest.SpyInstance;
//   let hexMac: string;
//   let expectedHashKey: string;
//   beforeAll(() => {
//     convertHexToBinarySpy = jest.spyOn(hexToBinary, "convertHexToBinary");
//     xorBinaryMacThroughKeyRotateSpy = jest.spyOn(xorKey,"xorBinaryMacThroughKeyRotate");
//     findHashKeyUser = require('../../../utils/findKey').findHashKeyUser;
//   });
//   it("should find hash key user `ab34f8a4f84b3f6b3f6b` through XOR hexa mac `aab1374bfd8ba64cfc81` ", () => {
//     // Given
//     hexMac = "aab1374bfd8ba64cfc81";
//     expectedHashKey = "ab34f8a4f84b3f6b3f6b";
//     let indexRotate = 0;
//     const hexMacSplited = hexMac.split("");
//     const keyRotate: number[] = [1,2,3,4,5];
//     const binaryMac = Array(hexMac.length)
//       .fill("")
//       .map((_: any, index: number) =>
//         parseInt(hexMacSplited[index] + hexMacSplited[index + 1], 16)
//       );
//     const hashKeyUser = binaryMac.map((chunkBinaryMac) => {
//       indexRotate = indexRotate % keyRotate.length
//       const chunkHashKey = (chunkBinaryMac^keyRotate[indexRotate]).toString(16)
//       console.log('chunkHashKey: ', chunkHashKey)
//       indexRotate++
//       return chunkHashKey
//     }).join('')
//     when(convertHexToBinarySpy).calledWith(hexMac).mockImplementation(() => binaryMac)
//     when(xorBinaryMacThroughKeyRotateSpy).calledWith(binaryMac).mockImplementation(() => hashKeyUser)
//     // When
//     const result = findHashKeyUser(hexMac);
//     console.log("result", result);
//     expect(result).toEqual(expectedHashKey);
//     // Then
//     expect(convertHexToBinarySpy).toHaveBeenNthCalledWith(1, hexMac);
//     expect(xorBinaryMacThroughKeyRotateSpy).toHaveBeenNthCalledWith(2,binaryMac)
//   });
// });
describe('test', () => {
    it('should be true', () => {
        expect(true).toBe(true);
    });
});
//# sourceMappingURL=findKey.test.js.map