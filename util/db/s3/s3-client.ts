import { S3Client } from '@aws-sdk/client-s3'

declare global {
  var _s3: S3Client
}

let CustomS3: S3Client

const accessKeyId = process.env.NEXT_PUBLIC_AWS_ACCESS_KEY_ID
const secretAccessKey = process.env.NEXT_PUBLIC_AWS_SECRET_ACCESS_KEY
const region = process.env.NEXT_PUBLIC_S3_BUCKET_REGION

if (!accessKeyId || !secretAccessKey || !region) {
  throw new Error('Check .env file')
}

if (process.env.NODE_ENV === 'development') {
  if (!global._s3) {
    global._s3 = new S3Client({
      credentials: {
        accessKeyId,
        secretAccessKey,
      },
      region,
    })
  }
  CustomS3 = global._s3
} else {
  CustomS3 = new S3Client({
    credentials: {
      accessKeyId,
      secretAccessKey,
    },
    region,
  })
}

export default CustomS3
