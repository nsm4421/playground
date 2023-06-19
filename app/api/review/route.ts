import prisma from '@/util/prsima'
import { NextRequest, NextResponse } from 'next/server'

// 일단은 가짜 유저와 가짜 식당을 DB에 넣어놓음
// insert into User(email, password, nickname) values('test@naver.com', '1234', 'test');
// insert into Restaurant(name, description) values("홍콩반점", "30년전통");
// 해당 유저와 식당에 리뷰를 날리는 요청을 통해 테스트

export async function GET(req: NextRequest) {
  const restaurantId = await req.nextUrl.searchParams.get('restaurantId')
  const page = Number(await req.nextUrl.searchParams.get('page'))

  if (!restaurantId)
    return NextResponse.json(
      {},
      { status: 400, statusText: 'restaurant id parameter is invalid' }
    )
  if (!page)
    return NextResponse.json(
      {},
      { status: 400, statusText: 'page parameter is invalid' }
    )

  try {
    const reviews = await prisma.review.findMany({
      skip: 10 * (page - 1),
      take: 10,
      where: {
        restaurantId,
      },
    })
    const totalCount = await prisma.review.count({ where: { restaurantId } })
    return NextResponse.json(
      { reviews, totalCount },
      {
        status: 200,
        statusText: 'Success to get reviews',
      }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'Server Fail' })
  }
}

export async function POST(req: NextRequest) {
  const { restaurantId, rating, menu, content } = await req.json()

  try {
    // TODO : 로그인한 유저를 가져오도록 설정

    const res = await prisma.review.create({
      data: {
        content,
        rating,
        menu,
        restaurant: {
          connect: { id: restaurantId },
        },
        user: {
          connect: { id: 'TODO' },
        },
      },
    })
    return NextResponse.json(res, {
      status: 200,
      statusText: 'Success to write',
    })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'Server Fail' })
  }
}

export async function PUT(req: NextRequest) {
  const { reviewId, restaurantId, rating, menu, content } = await req.json()
  // TODO : 리뷰작성자와 로그인한 유저가 동일한 유저인지 확인하는 로직
  try {
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
    return NextResponse.json({}, { status: 500, statusText: 'Server Fail' })
  }
}

export async function DELETE(req: NextRequest) {
  const restaurantId = await req.nextUrl.searchParams.get('restaurantId')
  const reviewId = await req.nextUrl.searchParams.get('reviewId')
  if (!restaurantId)
    return NextResponse.json(
      {},
      { status: 400, statusText: 'restaurant id parameter is invalid' }
    )
  if (!reviewId)
    return NextResponse.json(
      {},
      { status: 400, statusText: 'review id parameter is invalid' }
    )
  // TODO : 리뷰작성자와 로그인한 유저가 동일한 유저인지 확인하는 로직
  try {
    await prisma.review.delete({
      where: {
        id: reviewId,
      },
    })
    return NextResponse.json(
      {},
      { status: 200, statusText: 'Success to delete' }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'Server Fail' })
  }
}
