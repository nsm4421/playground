'use client'

import S3 from '@/util/s3'
import { PutObjectCommand } from '@aws-sdk/client-s3'

export default function Test() {
  const bucket = S3

  const upload = async (e: any) => {
    const file = await e.target.files[0]
    console.log(file)
    if (!file) return
    try {
      const uploadParams = {
        Bucket: process.env.NEXT_PUBLIC_S3_BUCKET_NAME,
        Key: file.name,
        Body: file,
        ContentType: file.type,
      }
      const res = await bucket.send(new PutObjectCommand(uploadParams))
      console.log(res)
      console.log(res.$metadata.httpStatusCode)
    } catch (err) {
      console.error(err)
      console.log('fail')
    }
  }

  return (
    <>
      <input type="file" onClick={upload} />
    </>
  )
}
