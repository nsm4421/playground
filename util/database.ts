import { MongoClient } from "mongodb";
const uri = process.env.MONGO_URI;
let connectDB:Promise<MongoClient>
if (!uri) throw new Error()

// add code belowd on global.global.d.ts to avoid type error
// declare var _mongo: typeof MongoClient;
if (process.env.NODE_ENV === 'development') {
  if (!global._mongo) {
    global._mongo = new MongoClient(uri).connect()
  }
  connectDB = global._mongo
} else {
  connectDB = new MongoClient(uri).connect()
}
export { connectDB }