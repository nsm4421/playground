import { authOptions } from '@/app/api/auth/[...nextauth]/route'
import { getServerSession } from 'next-auth'
import SignUpForm from './sign-up-form'

export default async function SignIn() {
  const session = await getServerSession(authOptions)

  if (session) return <div>Already have account...</div>
  return (
    <>
      <div className="flex justify-center mt-5">
        <div className="max-w-5xl w-full">
          <SignUpForm />
        </div>
      </div>
    </>
  )
}
