import { getServerSession } from 'next-auth'
import SignInForm from './sign-in-form'
import { authOptions } from '@/app/api/auth/[...nextauth]/route'

export default async function SignInPage() {
  const session = await getServerSession(authOptions)
  if (session) return <div>Already have account...</div>
  return (
    <>
      <div className="flex justify-center mt-10">
        <div className="w-full max-w-5xl">
          <SignInForm />
        </div>
      </div>
    </>
  )
}
