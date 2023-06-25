import { PutObjectCommand } from '@aws-sdk/client-s3'
import S3Client from './s3-client'
import convertURLtoFile from '../../conver-url-to-file'

/**
 * 파일 업로드 후
 * @param url file url
 * @returns uploaded filename
 */
export default async function uploadImageAndReturnFilename(url: string) {
  try {
    if (await !url) return null
    const file = await convertURLtoFile(url)
    const filename = `${process.env.NEXT_PUBLIC_S3_URL_PREFIX}/${Math.random()
      .toString(36)
      .slice(2, 30)}_${new Date().toString()}_${file.name}`
    const res = await S3Client.send(
      new PutObjectCommand({
        Bucket: process.env.NEXT_PUBLIC_S3_BUCKET_NAME,
        Key: filename,
        Body: file,
        ContentType: file.type,
      })
    )
    if (res.$metadata.httpStatusCode?.toString() == '200') {
      return filename
    }
    return null
  } catch (err) {
    console.error(err)
  }
}
