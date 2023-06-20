import prisma from '@/util/prsima'
import bcrypt from 'bcrypt'
import { NextRequest, NextResponse } from 'next/server'

/// Check email or nickname is duplicated or not
export async function GET(req: NextRequest) {
  try {
    // parsing request
    const field = await req.nextUrl.searchParams.get('field')
    if (!field)
      return NextResponse.json(
        { type: 'INVALID_PARAMETER' },
        { status: 200, statusText: 'invalid parameter' }
      )
    // check value
    const value = await req.nextUrl.searchParams.get('value')
    if (!value)
      return NextResponse.json(
        { type: 'INVALID_PARAMETER' },
        { status: 200, statusText: 'input value is not given' }
      )
    // find DB
    const user = await prisma.user.findUnique({ where: { [field]: value } })
    // duplicated
    if (user)
      return NextResponse.json(
        { type: 'DUPLICATED' },
        { status: 200, statusText: 'duplicated' }
      )
    // not duplicated
    return NextResponse.json(
      { type: 'SUCCESS' },
      { status: 200, statusText: 'success' }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json(
      { type: 'ERROR' },
      { status: 500, statusText: '서버오류 입니다' }
    )
  }
}

export async function POST(req: NextRequest) {
  try {
    // check parameters
    const { email, password, nickname } = await req.json()
    if (typeof email != 'string' || typeof password != 'string')
      return NextResponse.json(
        {},
        { status: 400, statusText: 'email or password is invalid' }
      )
    // check email is unique
    if (await prisma.user.findFirst({ where: { email } }))
      return NextResponse.json(
        {},
        { status: 400, statusText: 'email is duplicated' }
      )
    // check nickname is unique
    if (nickname) {
      if (await prisma.user.findFirst({ where: { nickname } }))
        return NextResponse.json(
          {},
          { status: 400, statusText: 'nickname is duplicated' }
        )
    }
    // create user
    const hashed = await bcrypt.hash(password, 10)
    const user = await prisma.user.create({
      data: { email, password: hashed, nickname },
    })
    return NextResponse.json(
      { ...user, password: null },
      { status: 200, statusText: 'sign up success' }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'server error' })
  }
}
