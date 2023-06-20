'use client'

import IconButton from '@/components/icon-button-component'
import Input from '@/components/input-component'
import axios from 'axios'
import { Dispatch, SetStateAction, useEffect, useState } from 'react'
import { AiFillMail, AiOutlineCheck, AiOutlineKey } from 'react-icons/ai'

interface Props {
  email: string
  setEmail: Dispatch<SetStateAction<string>>
  password: string
  setPassword: Dispatch<SetStateAction<string>>
}

export default function SignUpFormRequired(props: Props) {
  const [isLoading, setIsLoading] = useState<boolean>(false)
  const [emailTooltip, setEmailTooltip] = useState<string>('')
  const [emailChecked, setEmailChecked] = useState<boolean>(false)

  const checkEmail = async () => {
    if (!props.email) {
      setEmailTooltip('이메일을 입력해주세요')
      setEmailChecked(false)
      return
    }
    setIsLoading(true)
    await axios
      .get(`/api/auth/sign-up?field=email&email=${props.email}`)
      .then((res) => res.data)
      .then((data) => data.type)
      .then((type) => {
        switch (type) {
          case 'SUCCESS':
            setEmailTooltip(`${props.email}은 사용 가능한 이메일입니다`)
            setEmailChecked(true)
            break
          case 'INVALID_PARAMETER':
            setEmailTooltip('이메일을 입력해주세요')
            setEmailChecked(false)
            break
          case 'DUPLICATED':
            setEmailTooltip(`${props.email}은 이미 가입된 이메일입니다`)
            setEmailChecked(false)
            break
          default:
            setEmailTooltip('서버 오류가 발생했습니다')
            setEmailChecked(false)
        }
      })
      .catch((err) => {
        console.error(err)
        setEmailTooltip('서버 오류가 발생했습니다')
      })
      .finally(() => setIsLoading(false))
  }

  useEffect(() => {
    setEmailChecked(false)
  }, [props.email])
  return (
    <>
      {/* Email */}
      <div className="p-2 mt-5">
        <div className="font-semibold flex">
          <AiFillMail className="mt-1 mr-1 text-lg" />
          <label>이메일</label>
        </div>
        <div className="flex justify-start mt-2">
          <div className="w-9/12 mr-3">
            <Input
              content={props.email}
              setContent={props.setEmail}
              maxCharactor={30}
              placeholder="example@naver.com"
            />
          </div>
          <IconButton
            onClick={checkEmail}
            disabled={emailChecked || !props.email || isLoading}
            className={
              'disabled:cursor-not-allowed bg-none hover:text-orange-500 text-slate-700 dark:text-slate-300 font-bold py-2 px-4 rounded-lg inline-flex items-center'
            }
            icon={
              emailChecked ? (
                <AiOutlineCheck className="mr-2" />
              ) : (
                <AiFillMail className="mr-2" />
              )
            }
            label={emailChecked ? 'Ok' : '중복체크'}
          />
        </div>

        <span className="pl-3 text-sm text-gray-400 dark:text-slate-500">
          {emailTooltip}
        </span>
      </div>

      {/* Password */}
      <div className="p-2 mt-5">
        <div className="font-semibold flex">
          <AiOutlineKey className="mt-1 mr-1 text-xl" />
          <label>비밀번호</label>
        </div>
        <div className="flex justify-start mt-2">
          <div className="w-10/12 mr-3">
            <Input
              type="password"
              content={props.password}
              setContent={props.setPassword}
              maxCharactor={30}
              placeholder="1q2w3e4r!"
            />
          </div>
        </div>
      </div>
    </>
  )
}
