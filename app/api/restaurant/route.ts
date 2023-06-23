import RestaurantModel from '@/util/model/restaurant-model'
import prisma from '@/util/prsima'
import { getServerSession } from 'next-auth'
import { NextRequest, NextResponse } from 'next/server'
import { authOptions } from '../auth/[...nextauth]/route'

const findUnique = async (restaurantId: string) => {
  const restaurant = (await prisma.restaurant.findUniqueOrThrow({
    where: {
      id: restaurantId,
    },
  })) as RestaurantModel
  return { restaurant }
}

const findMany = async (page: number) => {
  const resturants = (await prisma.restaurant.findMany({
    skip: (page - 1) * 10,
    take: 10,
  })) as RestaurantModel[]
  const totalCount = (await prisma.restaurant.count()) as number
  return { resturants, totalCount }
}

const findManyWithCategory = async (page: number, category: string) => {
  const resturants = (await prisma.restaurant.findMany({
    skip: (page - 1) * 10,
    take: 10,
    where: {
      category,
    },
  })) as RestaurantModel[]
  const totalCount = (await prisma.restaurant.count({
    where: {
      category,
    },
  })) as number
  return { resturants, totalCount }
}

export async function GET(req: NextRequest) {
  // check logined or not
  const session = await getServerSession(authOptions)
  if (!session?.user) {
    return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
  }
  // parse url params
  const restaurantId = await req.nextUrl.searchParams.get('restaurantId')
  const page = await req.nextUrl.searchParams.get('page')
  const category = await req.nextUrl.searchParams.get('category')
  if (await (!restaurantId && !page && !category)) {
    return NextResponse.json(
      {},
      { status: 400, statusText: 'INVALID_PARAMETER' }
    )
  }

  try {
    let res
    // Case Ⅰ) find by id
    if (restaurantId) res = await findUnique(restaurantId)
    // Case Ⅱ) find many with category
    else if (category) res = await findManyWithCategory(Number(page), category)
    // Case Ⅲ) find many
    else res = await findMany(Number(page))
    return NextResponse.json(res, {
      status: 200,
      statusText: 'SUCCESS',
    })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}

export async function POST(req: NextRequest) {
  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session?.user) {
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    }
    // check request
    const { name, category, description } = await req.json()
    if (!name || !category || !description)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    const res = await prisma.restaurant.create({
      data: {
        name,
        category,
        description,
        createdBy: session.user.id,
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
    // check request
    const { restaurantId, name, category, description } = await req.json()
    if (!restaurantId || !name || !category || !description)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    // find restauarnt
    const restaurant = await prisma.restaurant.findUniqueOrThrow({
      where: { id: restaurantId },
    })
    if (!restaurant)
      return NextResponse.json({}, { status: 400, statusText: 'NOT_FOUND' })
    // check author
    if (restaurant.createdBy != session.user.id)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'NOT_AUTHORIZED' }
      )
    // update
    const res = await prisma.restaurant.update({
      where: { id: restaurantId },
      data: {
        name,
        category,
        description,
        updatedBy: session.user.id,
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

export async function DELETE(req: NextRequest) {
  try {
    // check logined or not
    const session = await getServerSession(authOptions)
    if (!session?.user) {
      return NextResponse.json({}, { status: 400, statusText: 'UNAUTHORIZED' })
    }
    // parse url params
    const restaurantId = await req.nextUrl.searchParams.get('restaurantId')
    if (!restaurantId)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    // find restauarnt
    const restaurant = await prisma.restaurant.findUniqueOrThrow({
      where: { id: restaurantId },
    })
    if (!restaurant)
      return NextResponse.json({}, { status: 400, statusText: 'NOT_FOUND' })
    // check author
    if (restaurant.createdBy != session.user.id)
      return NextResponse.json(
        {},
        { status: 400, statusText: 'NOT_AUTHORIZED' }
      )
    // delete
    await prisma.restaurant.delete({
      where: { id: restaurantId },
    })
    return NextResponse.json(
      {},
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
