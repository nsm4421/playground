'use client'

import categoriesItem from '@/util/model/category-items'
import { useEffect, useState } from 'react'
import CateoryTab from './category-tab'
import useAxios from '@/util/hook/use-axios'
import RestuarantModel from '@/util/model/restaurant-model'
import RestuarntItem from './restaurant-item'
import Pagination from '@/components/pagination-component'

type ResponseData = {
  resturants: RestuarantModel[]
  totalCount: number
}

export default function RestaurntItems() {
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

  return (
    <>
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
          <div className="max-w-fit">
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
        <section className="grid grid-cols-2 md:grid-cols-3 gap-2 mt-10">
          {data?.resturants?.map((restuarant, idx) => (
            <div className="h-auto max-w-full rounded-lg" key={idx}>
              <RestuarntItem restaurant={restuarant} />
            </div>
          ))}
        </section>
      )}
    </>
  )
}
