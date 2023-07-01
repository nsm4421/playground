import { DeleteObjectCommand, PutObjectCommand } from '@aws-sdk/client-s3'
import S3Client from './s3-client'
/**
 * 파일 삭제
 * @param url file url
 * @returns
 */
export default async function deleteFile(key: string) {
  try {
    if (await !key) return
    await S3Client.send(
      new DeleteObjectCommand({
        Key: key,
        Bucket: process.env.NEXT_PUBLIC_S3_BUCKET_NAME,
      })
    )
  } catch (err) {
    console.error(err)
  }
}
