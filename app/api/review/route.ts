import prisma from '@/util/prsima'
import { getServerSession } from 'next-auth'
import { NextRequest, NextResponse } from 'next/server'
import { authOptions } from '../auth/[...nextauth]/route'

// 일단은 가짜 유저와 가짜 식당을 DB에 넣어놓음
// insert into User(email, password, nickname) values('test@naver.com', '1234', 'test');
// insert into Restaurant(name, description) values("홍콩반점", "30년전통");
// 해당 유저와 식당에 리뷰를 날리는 요청을 통해 테스트

export async function GET(req: NextRequest) {
  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    }
    // check parameters
    const restaurantId = await req.nextUrl.searchParams.get('restaurantId')
    const page = Number(await req.nextUrl.searchParams.get('page'))

    if (!restaurantId || !page)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    const reviews = await prisma.review.findMany({
      skip: 10 * (page - 1),
      take: 10,
      where: {
        restaurantId,
      },
      orderBy: { createdAt: 'desc' },
    })
    const totalCount = await prisma.review.count({ where: { restaurantId } })
    return NextResponse.json(
      { reviews, totalCount },
      {
        status: 200,
        statusText: 'SUCCESS',
      }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}

export async function POST(req: NextRequest) {
  const { restaurantId, rating, menu, content } = await req.json()

  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session?.user) {
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    }

    const res = await prisma.review.create({
      data: {
        content,
        rating,
        menu,
        restaurant: {
          connect: { id: restaurantId },
        },
        user: {
          connect: { id: session.user.userId },
        },
      },
    })
    return NextResponse.json(res, {
      status: 200,
      statusText: 'SUCCESS',
    })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}

export async function PUT(req: NextRequest) {
  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session?.user) {
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    }
    // check params
    const { reviewId, restaurantId, rating, menu, content } = await req.json()
    const res = await prisma.review.update({
      data: {
        content,
        rating,
        menu,
        restaurant: {
          connect: { id: restaurantId },
        },
        user: {
          connect: { id: restaurantId },
        },
      },
      where: {
        id: reviewId,
      },
    })
    return NextResponse.json(res, {
      status: 200,
      statusText: 'Success to write',
    })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}

export async function DELETE(req: NextRequest) {
  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session?.user) {
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    }
    // check params
    const restaurantId = await req.nextUrl.searchParams.get('restaurantId')
    const reviewId = await req.nextUrl.searchParams.get('reviewId')
    if (!restaurantId)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    if (!reviewId)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    const review = await prisma.review.findUniqueOrThrow({
      where: {
        id: reviewId,
      },
    })
    // check author
    if (review.userId != session.user.userId)
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    // delete
    await prisma.review.delete({
      where: {
        id: reviewId,
      },
    })
    return NextResponse.json({}, { status: 200, statusText: 'SUCCESS' })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}
