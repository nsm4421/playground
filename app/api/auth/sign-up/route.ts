import prisma from '@/util/db/prisma/prsima-client'
import bcrypt from 'bcrypt'
import { NextRequest, NextResponse } from 'next/server'

/// Check email or nickname is duplicated or not
export async function GET(req: NextRequest) {
  try {
    // parsing request
    const field = await req.nextUrl.searchParams.get('field')
    if (!field)
      return NextResponse.json(
        {},
        {
          status: 400,
          statusText: 'INVALID_PARAMETER',
        }
      )
    // check value
    const value = await req.nextUrl.searchParams.get('value')
    if (!value)
      return NextResponse.json(
        {},
        {
          status: 400,
          statusText: 'INVALID_PARAMETER',
        }
      )
    // find DB
    const user = await prisma.user.findUnique({ where: { [field]: value } })
    // duplicated
    if (user)
      return NextResponse.json(
        {},
        {
          status: 400,
          statusText: 'DUPLICATED',
        }
      )
    // not duplicated
    return NextResponse.json({}, { status: 200, statusText: 'g' })
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}

export async function POST(req: NextRequest) {
  try {
    // check parameters
    const { email, password, nickname } = await req.json()
    if (typeof email != 'string' || typeof password != 'string')
      return NextResponse.json(
        {},
        { status: 400, statusText: 'INVALID_PARAMETER' }
      )
    // check email is unique
    if (await prisma.user.findFirst({ where: { email } }))
      return NextResponse.json(
        {},
        { status: 400, statusText: 'DUPLICATED_EMAIL' }
      )
    // check nickname is unique
    if (nickname) {
      if (await prisma.user.findFirst({ where: { nickname } }))
        return NextResponse.json(
          {},
          { status: 400, statusText: 'DUPLICATED_NICKNAME' }
        )
    }
    // create user
    const hashed = await bcrypt.hash(password, 10)
    const user = await prisma.user.create({
      data: { email, password: hashed, nickname },
    })
    return NextResponse.json(
      { ...user, password: null },
      { status: 200, statusText: 'SUCCESS' }
    )
  } catch (err) {
    console.error(err)
    return NextResponse.json({}, { status: 500, statusText: 'SERVER_ERROR' })
  }
}
