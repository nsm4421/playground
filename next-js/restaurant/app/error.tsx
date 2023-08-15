'use client'

import Button from '@/components/atom/button-component'
import { useRouter } from 'next/navigation'

export default function ErrorPage() {
  const router = useRouter()
  return (
    <div className="flex justify-center mt-10 mx-3">
      <div className="w-full max-w-5xl p-2">
        <h1 className="text-3xl">에러가 발생했습니다...</h1>
        <div className="flex justify-start mt-5">
          <div className="mr-5">
            <Button label={'홈으로'} onClick={() => router.push('/')} />
          </div>
          <Button label={'뒤로가기'} onClick={() => router.back()} />
        </div>
      </div>
    </div>
  )
}
