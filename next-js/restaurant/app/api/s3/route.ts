import S3Client from '@/util/db/s3/s3-client'
import { GetObjectCommand } from '@aws-sdk/client-s3'
import { NextRequest, NextResponse } from 'next/server'

export async function GET(req: NextRequest) {
  try {
    // check parameters
    const Key = await req.nextUrl.searchParams.get('key')
    if (!Key)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    // S3로 GET요청 보내기
    const base64Image = await S3Client.send(
      new GetObjectCommand({
        Bucket: process.env.NEXT_PUBLIC_S3_BUCKET_NAME,
        Key,
      })
    )
      .then((res) => res.Body)
      // Base64이미지로 변환
      .then((body) => body?.transformToByteArray())
      .then((arr) => arr && Buffer.from(arr).toString('base64'))

    if (!base64Image)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'ENTITY_NOT_FOUND' }
      )

    return NextResponse.json(
      { data: base64Image },
      { status: 200, statusText: 'SUCCESS' }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}
