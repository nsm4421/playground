import { PrismaClient } from '@prisma/client'

declare global {
  var _prisma: PrismaClient
}
let prisma: PrismaClient

if (process.env.NODE_ENV === 'development') {
  if (!global._prisma) {
    global._prisma = new PrismaClient({ log: ['query', 'info'] })
  }
  prisma = global._prisma
} else {
  prisma = new PrismaClient()
}

export default prisma
