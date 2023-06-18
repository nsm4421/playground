import prisma from '@/util/prsima'
import { NextRequest, NextResponse } from 'next/server'

export async function GET(req: NextRequest) {
  const restaurantId = Number(
    await req.nextUrl.searchParams.get('restaurantId')
  )
  if (!restaurantId)
    return NextResponse.json(
      {},
      { status: 400, statusText: 'restaurant id parameter is invalid' }
    )
  try {
    const res = await prisma.restaurant.findUniqueOrThrow({
      where: {
        id: restaurantId,
      },
    })
    return NextResponse.json(res, {
      status: 200,
      statusText: 'Success to get resturant',
    })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'Server Fail' })
  }
}

export async function POST(req: NextRequest) {
  const { name, category, description } = await req.json()
  if (!name || !category || !description)
    return NextResponse.json(
      {},
      { status: 400, statusText: 'body is not given' }
    )
  try {
    const res = await prisma.restaurant.create({
      data: {
        name,
        category,
        description,
      },
    })
    return NextResponse.json(res, {
      status: 200,
      statusText: 'Success to create resturant',
    })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'Server Fail' })
  }
}
