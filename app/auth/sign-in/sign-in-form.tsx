'use client'

import { useRouter } from 'next/navigation'
import { useState } from 'react'
import Button from '@/components/button-component'
import Modal from '@/components/modal-component'
import { signIn } from 'next-auth/react'
import { AiFillMail, AiOutlineKey } from 'react-icons/ai'
import Input from '@/components/input-component'
import Link from 'next/link'

export default function SignInForm() {
  const router = useRouter()
  const [email, setEmail] = useState<string>('')
  const [password, setPassword] = useState<string>('')
  const [modalMessage, setModalMessage] = useState<string | undefined>()

  const handleSignIn = async () => {
    if (!email) {
      setModalMessage('이메일을 입력해주세요')
      return
    }
    if (!password) {
      setModalMessage('비밀번호을 입력해주세요')
      return
    }
    const res = await signIn('credentials', {
      email,
      password,
      redirect: false,
    })
    if (res?.error) {
      setModalMessage(res.error)
      return
    }
    router.push('/')
    return
  }

  return (
    <>
      {modalMessage && (
        <Modal
          title="로그인 실패"
          modalMessage={modalMessage}
          setModalMessage={setModalMessage}
        />
      )}

      <div className="flex justify-between">
        <h1 className="text-2xl font-extrabold text-blue-900 dark:text-blue-200">
          로그인
        </h1>

        <Button
          onClick={handleSignIn}
          className="disabled:cursor-not-allowed bg-slate-100 dark:bg-slate-600 hover:text-orange-500 text-slate-700 dark:text-slate-100 font-bold py-2 px-4 rounded-lg inline-flex items-center"
          label={'제출하기'}
        />
      </div>

      <form className="p-2 mt-5 shadow-sm shadow-slate-300 dark:shadow-slate-700">
        {/* Email */}
        <div className="p-2">
          <div className="font-semibold flex">
            <AiFillMail className="mt-1 mr-1 text-lg" />
            <label>이메일</label>
          </div>
          <div className="flex justify-start mt-2">
            <Input
              content={email}
              setContent={setEmail}
              maxCharactor={30}
              placeholder="example@naver.com"
            />
          </div>
        </div>
        {/* Password */}
        <div className="p-2 mt-5">
          <div className="font-semibold flex">
            <AiOutlineKey className="mt-1 mr-1 text-lg" />
            <label>비밀번호</label>
          </div>
          <div className="flex justify-start mt-2">
            <Input
              content={password}
              setContent={setPassword}
              maxCharactor={30}
              placeholder="1q2w3e4r!"
            />
          </div>
        </div>
      </form>

      <footer className="text-sm text-slate-500 dark:text-slate-400 p-2 mt-3">
        <span>
          혹시 아직 계정이 없으신가요?{' '}
          <Link
            href="/auth/sign-up"
            className="font-bold text-blue-950 dark:text-slate-100 hover:text-orange-400 "
          >
            회원가입
          </Link>{' '}
          하러 가기
        </span>
      </footer>
    </>
  )
}
