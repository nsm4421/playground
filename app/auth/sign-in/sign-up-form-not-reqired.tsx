'use client'

import IconButton from '@/components/icon-button-component'
import Input from '@/components/input-component'
import axios from 'axios'
import { Dispatch, SetStateAction, useState } from 'react'
import {
  AiFillAccountBook,
  AiOutlineCheck,
  AiOutlineUser,
} from 'react-icons/ai'

interface Props {
  nickname: string
  setNickname: Dispatch<SetStateAction<string>>
}

export default function SignUpFormNotRequired(props: Props) {
  const [isLoading, setIsLoading] = useState<boolean>(false)
  const [nicknameTooltip, setNicknameTooltip] = useState<string>(
    '닉네임을 정하지 않으면 랜덤으로 생성된 문자열을 초기 닉네임으로 지정합니다'
  )
  const [nicknameChecked, setNicknameChecked] = useState<boolean>(false)

  const checkNickname = async () => {
    if (!props.nickname) {
      setNicknameTooltip('닉네임을 입력해주세요')
      setNicknameChecked(false)
      return
    }
    setIsLoading(true)
    await axios
      .get(`/api/auth/sign-up?field=nickname&value=${props.nickname}`)
      .then((res) => res.data)
      .then((data) => data.type)
      .then((type) => {
        switch (type) {
          case 'SUCCESS':
            setNicknameTooltip(`${props.nickname}은 사용 가능한 이메일입니다`)
            setNicknameChecked(true)
            break
          case 'INVALID_PARAMETER':
            setNicknameTooltip('이메일을 입력해주세요')
            setNicknameChecked(false)
            break
          case 'DUPLICATED':
            setNicknameTooltip(`${props.nickname}은 이미 사용중인 닉네임입니다`)
            setNicknameChecked(false)
            break
          default:
            setNicknameTooltip('서버 오류가 발생했습니다')
            setNicknameChecked(false)
        }
      })
      .catch((err) => {
        console.error(err)
        setNicknameTooltip('서버 오류가 발생했습니다')
      })
      .finally(() => setIsLoading(false))
  }

  return (
    <>
      {/* Email */}
      <div className="p-2 mt-5">
        <div className="font-semibold flex">
          <AiFillAccountBook className="mt-1 mr-1 text-lg" />
          <label>닉네임</label>
        </div>
        <div className="flex justify-start mt-2">
          <div className="w-9/12 mr-3">
            <Input
              content={props.nickname}
              setContent={props.setNickname}
              maxCharactor={30}
              placeholder="상도동카르마"
            />
          </div>
          <IconButton
            onClick={checkNickname}
            disabled={nicknameChecked || !props.nickname || isLoading}
            className={
              'disabled:cursor-not-allowed bg-none hover:text-orange-500 text-slate-700 dark:text-slate-300 font-bold py-2 px-4 rounded-lg inline-flex items-center'
            }
            icon={
              nicknameChecked ? (
                <AiOutlineCheck className="mr-2" />
              ) : (
                <AiOutlineUser className="mr-2" />
              )
            }
            label={nicknameChecked ? 'Ok' : '중복체크'}
          />
        </div>

        <span className="pl-3 text-sm text-gray-400 dark:text-slate-500">
          {nicknameTooltip}
        </span>
      </div>
    </>
  )
}
