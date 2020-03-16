describe('convertHexToBinary', () => {
    let hashHexKey;
    let convertHexToBinary;
    beforeAll(() => {
        convertHexToBinary = require('../../../utils/hexToBinary').convertHexToBinary;
    });
    it('should convert Hex `ab34f8a4f84b3f6b3f6b` to Binary session Key `171179527924813816479248132`', () => {
        // Given
        hashHexKey = 'ab34f8a4f84b3f6b3f6b';
        const hexKeySplited = hashHexKey.split('');
        const expectedResult = Array(hashHexKey.length / 2)
            .fill('')
            .map((_, index) => parseInt(hexKeySplited[index] + hexKeySplited[index + 1], 16));
        // When
        const result = convertHexToBinary(hashHexKey);
        // Then
        expect(result).toEqual(expectedResult);
    });
});
//# sourceMappingURL=hexToBinary.test.js.map