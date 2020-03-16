import * as rp from 'request-promise'

describe('Authentificate',() => {
    it('should reject user when he doesnt have token', async () => {
        const result = await rp.default('http://127.0.0.1:7000/esport/jeux/dqdzdqzd')
        expect(result).toBe('Unauthorized')
    })
})