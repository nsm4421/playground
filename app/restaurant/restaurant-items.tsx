'use client'

import categoriesItem from '@/util/model/category-items'
import { useEffect, useState } from 'react'
import CateoryTab from './category-tab'
import useAxios from '@/util/hook/use-axios'
import RestuarantModel from '@/util/model/restaurant-model'
import RestuarntItem from './restaurant-item'
import Pagination from '@/components/atom/pagination-component'
import { HiOutlinePencilSquare } from 'react-icons/hi2'
import IconButton from '@/components/atom/icon-button-component'
import Link from 'next/link'
import Loading from '@/components/loading-component'
import WriteReviewModal from '@/app/restaurant/write-review-modal'

type ResponseData = {
  resturants: RestuarantModel[]
  totalCount: number
}

export default function RestaurntItems() {
  /** States
   * selected : 현재 선택한 카테고리
   * page : 현재 선택한 음식점 list 페이지
   * currentRestaurntId : 리뷰를 작성할 음식점의 id state,
   */
  const [selected, setSelected] = useState(0)
  const [page, setPage] = useState(1)
  const { data, error, isLoading, refetch } = useAxios<ResponseData>({
    url:
      `/api/restaurant?page=${page}` +
      `${selected != 0 ? `&category=${categoriesItem[selected - 1]}` : ''}`,
  })

  useEffect(() => {
    refetch()
    return
  }, [selected])

  if (isLoading) return <Loading />

  return (
    <>
      <WriteReviewModal />
      {/* 카테고리 Slider, Pagination 바 */}
      <section>
        <div className="flex justify-start">
          <div className="max-w-fit mx-5">
            <CateoryTab
              labels={['전체', ...categoriesItem]}
              isLoading={isLoading}
              selected={selected}
              setSelected={setSelected}
            />
          </div>
          <div className="max-md:hidden">
            <Pagination
              page={page}
              setPage={setPage}
              totalCount={data?.totalCount ?? 0}
            />
          </div>
          <div className="ml-5">
            <Link href={'/restaurant/create'}>
              <IconButton
                icon={<HiOutlinePencilSquare className="mr-1" />}
                label={'글쓰기'}
              />
            </Link>
          </div>
        </div>
        <div className="flex justify-start mt-3 p-3">
          <div className="block md:hidden">
            <Pagination
              page={page}
              setPage={setPage}
              totalCount={data?.totalCount ?? 0}
            />
          </div>
        </div>
      </section>

      {/* 가게 Items */}
      {(!error || data?.resturants || data?.totalCount) && (
        <section className=" mt-10 w-full">
          {data?.resturants?.map((restuarant, idx) => (
            <div className="h-auto max-w-full rounded-lg mt-5" key={idx}>
              <RestuarntItem restaurant={restuarant} refetch={refetch} />
            </div>
          ))}
        </section>
      )}
    </>
  )
}
