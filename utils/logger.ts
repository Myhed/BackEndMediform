import { add, addColors, createLogger, format, Logger, transports } from 'winston'
import { IOptPrintLogger } from '../interfaces/logger'
const { combine, timestamp, printf, colorize } = format

const myFormat = printf(({ level, method, nameApp, chunkOriginalUrl, statusCode, message, timestamp }) => {
  if (typeof method !== 'undefined' && typeof nameApp !== 'undefined') {
    return `${timestamp} [ ${nameApp} ] - ${method} ${chunkOriginalUrl} ${statusCode || ''} ${level}: ${message}`
  }
  return `${timestamp} ${level}: ${message}`
})

export const logger: Logger = createLogger({
  format: combine(colorize(), timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }), myFormat),
  level: process.env.LEVEL,
  transports: [new transports.Console()],
})

export const httpLogger = (opt: IOptPrintLogger): Logger => {
  const { method, originalUrl, statusCode } = opt
  const originalUrlSplited = originalUrl.split('/').filter(chunkOriginalUrlLoop => chunkOriginalUrlLoop !== '')
  const nameApp =
    originalUrlSplited[0].toUpperCase() === 'ESPORT' || originalUrlSplited[0].toUpperCase() === 'MEDIFORM'
      ? originalUrlSplited[0].toUpperCase()
      : undefined
  const chunkOriginalUrl = `/${originalUrlSplited.splice(1, originalUrlSplited.length).join('/')}`

  return logger.child({ method, nameApp, chunkOriginalUrl, statusCode })
}

// export const logger: Logger = createLogger({
//     format: format.combine(
//         format.colorize(),export const logger: Logger = createLogger({
//     format: format.combine(
//         format.colorize(),
//         format.timestamp({format: 'YYYY-MM-DD HH:mm:ss:ms'}),
//         format.printf(info => `${info.timestamp} ${info.level} ${info.message}`)
//     ),
//     transports: [
//         new transports.File({
//             filename:'.//all-logs.log',
//             maxsize: 5242880,
//             maxFiles: 5,
//         }),
//         new transports.Console()
//     ]
// });
//         format.timestamp({format: 'YYYY-MM-DD HH:mm:ss:ms'}),
//         format.printf(info => `${info.timestamp} ${info.level} ${info.message}`)
//     ),
//     transports: [
//         new transports.File({
//             filename:'.//all-logs.log',
//             maxsize: 5242880,
//             maxFiles: 5,
//         }),
//         new transports.Console()
//     ]
// });
