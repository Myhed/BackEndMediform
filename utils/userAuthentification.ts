export function createToken() : string {
    return Array(16).fill(null)
    .map(index => (Math.floor((Math.random() * (255 - 0))))
    .toString(16)
    .padStart(2, '0'))
    .join('')
}

export function createMacFromToken(hexToken: string) : string {
    const mac: string[] = []
    const SALT: number = 42
    const k = hexToken.split('')
    let code: string
    for (let i = 0; i < k.length; i = i+2){
        code = k[i] + k[i+1]
        // console.log('ki: %s, ki++: %s, %s:%d', k[i], k[i+1], code, parseInt(code, 16))
        // nums[nums.length] = parseInt(code, 16)
        mac[mac.length] = (parseInt(code, 16) ^ SALT).toString(16)
    }

    console.log(mac.join(''))
    return mac.join('')
}

export function verifyTokenWithMac(mac: string, token: string) : boolean {
    return mac === createMacFromToken(token)
}