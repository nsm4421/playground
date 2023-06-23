'use client'

import { useRouter } from 'next/navigation'
import { useState } from 'react'
import SignUpFormRequired from './sign-up-form-required'
import SignUpFormNotRequired from './sign-up-form-not-reqired'
import Button from '@/components/button-component'
import axios, { AxiosError } from 'axios'
import Modal from '@/components/modal-component'

const LoginPageUrl = '/auth/sign-up'

export default function SignUpForm() {
  const router = useRouter()
  const [email, setEmail] = useState<string>('')
  const [password, setPassword] = useState<string>('')
  const [nickname, setNickname] = useState<string>('')
  const [modalMessage, setModalMessage] = useState<string | undefined>()

  const handleSignUp = async () => {
    if (!email) {
      setModalMessage('이메일을 입력해주세요')
      return
    }
    if (!password) {
      setModalMessage('비밀번호을 입력해주세요')
      return
    }
    await axios
      .post('/api/auth/sign-up', {
        email,
        password,
        nickname: nickname ? nickname : null,
      })
      .then(() => router.push(LoginPageUrl))
      .catch((err: AxiosError) => {
        console.error(err)
        switch (err.response?.statusText) {
          case 'INVALID_PARAMETER':
            setModalMessage('유효하지 않은 값이 주어졌습니다')
            break
          case 'DUPLICATED_EMAIL':
            setModalMessage('이메일이 중복되었습니다')
            break
          case 'DUPLICATED_NICKNAME':
            setModalMessage('닉네임이 중복되었습니다')
            break
          default:
            setModalMessage('서버 오류가 발생했습니다')
        }
      })
  }

  return (
    <>
      {modalMessage && (
        <Modal
          title="회원가입 실패"
          modalMessage={modalMessage}
          setModalMessage={setModalMessage}
        />
      )}
      <div className="mt-5 p-2">
        <div className="flex justify-between">
          <h1 className="text-2xl font-extrabold text-blue-900 dark:text-blue-200">
            회원가입
          </h1>
          <Button
            onClick={handleSignUp}
            className="disabled:cursor-not-allowed bg-blue-100 dark:bg-slate-600 hover:text-orange-500 text-slate-700 dark:text-slate-300 font-bold py-2 px-4 rounded-lg inline-flex items-center"
            label={'제출하기'}
          />
        </div>
      </div>

      <section className="mt-5 border-t border-b p-3 rounded-lg border-slate-300 dark:border-slate-600 shadow-lg dark:shadow-slate-700">
        <h1 className="text-xl font-bold text-rose-700 dark:text-rose-400">
          필수 작성항목
        </h1>
        <div className="text-rose-700 dark:text-rose-400">
          <SignUpFormRequired
            email={email}
            setEmail={setEmail}
            password={password}
            setPassword={setPassword}
          />
        </div>
      </section>

      <section className="mt-10 border-t border-b p-3 rounded-lg border-slate-300 dark:border-slate-600 shadow-lg dark:shadow-slate-700">
        <h1 className="text-xl font-bold text-green-700 dark:text-green-400">
          작성항목
        </h1>
        <div className="text-green-700 dark:text-green-400">
          <SignUpFormNotRequired
            nickname={nickname}
            setNickname={setNickname}
          />
        </div>
      </section>
    </>
  )
}
