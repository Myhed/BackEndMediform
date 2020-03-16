describe('xorBinaryMacThroughKeyRotate', () => {
    let xorBinaryMacThroughKeyRotate;
    beforeAll(() => {
        xorBinaryMacThroughKeyRotate = require('../../../utils/xorKey').xorBinaryMacThroughKeyRotate;
    });
    it('should create XOR hexa Mac`aab1374bfd8ba64cfc81` from binary key `171179527924813816479248132` through key rotate [1,2,3,4,5]', () => {
        // Given
        let indexKeyRotate = 0;
        const indexKey = [1, 2, 3, 4, 5];
        const hashHexKey = 'ab34f8a4f84b3f6b3f6b';
        const hexKeySplited = hashHexKey.split('');
        const macBinaryKeys = Array(hexKeySplited.length / 2)
            .fill('')
            .map((_, index) => parseInt(hexKeySplited[index] + hexKeySplited[index + 1], 16));
        const expectedMacHexKeys = macBinaryKeys
            .map(chunkBinaryKey => {
            indexKeyRotate = indexKeyRotate % indexKey.length;
            // tslint:disable-next-line: no-bitwise
            const macStr = (chunkBinaryKey ^ indexKey[indexKeyRotate]).toString(16);
            // tslint:disable-next-line: no-increment-decrement
            indexKeyRotate++;
            return macStr;
        })
            .join('');
        // When
        const result = xorBinaryMacThroughKeyRotate(macBinaryKeys);
        // Then
        expect(result).toEqual(expectedMacHexKeys);
    });
});
//# sourceMappingURL=xorKey.test.js.map