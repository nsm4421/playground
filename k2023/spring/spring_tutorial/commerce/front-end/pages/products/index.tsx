import productModel from 'constant/productModel'
import { useEffect, useState } from 'react'
import { css } from '@emotion/css'
import Image from 'next/image'
import MyEditor from '../../components/Editor'
import { Button, CloseButton, Input, Pagination, SegmentedControl, StarIcon, TextInput } from '@mantine/core'
import { EditorState, convertFromRaw } from 'draft-js'
import { Select } from '@mantine/core'

export default function Products() {
  /**
   * currentPage : 현재 페이지수
   * currentCategory : 현재 선택한 카테고리(default : ALL)
   * categories : 카테고리 종류
   * currentInput : 검색창에 입력된 키워드
   * searchInput : 현재 적용된 검색어
   * totoalPage : 전체 페이지수
   * products : 상품 List
   */
  const [currentPage, setCurrentPage] = useState<number>(1)
  const [currentCategory, setCurrentCategory] = useState<string>('ALL')
  const [currentSort, setCurrentSort] = useState<string | null>(null)
  const [categories, setCategories] = useState<
    { label: String; value: String }[]
  >([])
  const [currentKeyword, setCurrentKeyword] = useState<string>('')
  const [currentSearchType, setCurrentSearchType] = useState<string | null>(null)
  const [totoalPage, setTotalPage] = useState<number>(0)
  const [products, setProducts] = useState<productModel[]>([])

  const searchSelectMenu = [
    { value: 'NAME', label: '상품명' },
    { value: 'HASHTAG', label: '해시태그' },
    { value: 'DESCRIPTION', label: '상품설명' },
  ]

  const sortSelectMenu = [
    { value: 'price,asc', label: '가격 낮은 순' },
    { value: 'price,desc', label: '가격 높은 순' },
    { value: 'createdAt,asc', label: '최신 순' },
  ]

  const handleCurrentInput = (e: React.FormEvent<HTMLInputElement>) => setCurrentKeyword(e.currentTarget.value)
  const handleDeleteCurrentKeyword = () => {setCurrentKeyword('')}
  const getProducts = () => {
    fetch('/api/get-products', {
      method: 'POST',
      body: JSON.stringify({
        sort: currentSort,
        page: currentPage,
        category: currentCategory,
        keyword:currentKeyword,
        searchType :currentSearchType
      }),
    })
      .then((res) => res.json())
      .then((data) => {
        setProducts([...data.items.content])
        setTotalPage(data.items.totalPages)
      })
      .catch(console.error)
  }

  const getCategories = () => {
    fetch('/api/get-category')
    .then((res) => res.json())
    .then((data) =>
      setCategories([{ label: '전체', value: 'ALL' }, ...data.items])
    )
    .catch(console.error)
  }

  useEffect(() => {
    getCategories()
  }, [])

  useEffect(()=>{
    setCurrentPage(1)
  }, [currentCategory])

  // When end point change, Get product
  useEffect(() => {
    getProducts()
  }, [currentPage, currentCategory, currentSort])

  return (
    <>
      {/* Header */}
      <h1
        className={css`
          margin-bottom: 20px;
        `}
      >
        Products
      </h1>

      {/* Search */}
      <div
        className={css`
          align-items: center;
          display: flex;
        `}
      >
        <div
          className={css`
            margin-right: 10px;
          `}
        >
          <Select
            placeholder="Search"
            data={searchSelectMenu}
            value={currentSearchType}
            onChange={setCurrentSearchType}
            clearable
          />
        </div>
        <div
          className={css`
            min-width: 50%;
            margin-right: 10px;
          `}
        >
          <Input
            value={currentKeyword}
            onChange={handleCurrentInput}
            rightSection={
              <CloseButton
                onClick={handleDeleteCurrentKeyword}
                aria-label="Close modal"
              />
            }
            placeholder='검색어를 입력하세요'
          />
        </div>
        <div>
          <Button
            onClick={getProducts}
          >
            Search
          </Button>
        </div>
      </div>

      {/* Sort */}
      <div
        className={css`
          max-width: 300px;
          margin-bottom: 20px;
        `}
      >
        <Select
          clearable
          label="Sort"
          placeholder="Sort"
          data={sortSelectMenu}
          value={currentSort}
          onChange={setCurrentSort}
        />
      </div>

      {/* Category */}
      <div
        className={css`
          margin-bottom: 20px;
        `}
      >
        <SegmentedControl
          value={currentCategory}
          onChange={setCurrentCategory}
          data={[
            ...categories.map((cat) => ({
              label: String(cat.label),
              value: String(cat.value),
            })),
          ]}
          color="dark"
          defaultChecked={true}
          defaultValue={'ALL'}
        />
      </div>

      {/* Products */}
      <div>
        {products &&
          products.map((prod) => {
            const editorState = EditorState.createWithContent(
              convertFromRaw(JSON.parse(prod.description))
            )

            return (
              <div
                className={css`
                  padding: 5px;
                  display: grid;
                  grid-template-columns: repeat(2, 1fr);
                  grid-gap: 5px;
                `}
                key={prod.id}
              >
                <div>
                  {prod.imgUrl && (
                    <Image
                      width={300}
                      height={200}
                      src={prod.imgUrl}
                      alt={prod.name}
                      // TODO : add blur image
                      // placeholder="blur"
                      // blurDataURL=""
                      className={css`
                        border-radius: 10%;
                      `}
                    />
                  )}
                </div>

                <div
                  className={css`
                    padding: 5px;
                    display: grid;
                    grid-template-rows: 2fr 1fr 2fr;
                    grid-gap: 5px;
                  `}
                >
                  <div>
                    <p
                      className={css`
                        font-weight: 800;
                      `}
                    >
                      {prod.name}
                    </p>
                  </div>

                  <div
                    className={css`
                      display: flex;
                      justify-content: space-between;
                      width: 300px;
                      margin-top: 5px;
                    `}
                  >
                    <span>\{prod.price?.toLocaleString('ko-KR')}</span>
                    <span
                      className={css`
                        font-style: italic;
                        color: gray;
                      `}
                    >
                      {prod.category}
                    </span>
                  </div>

                  <MyEditor editorState={editorState} readOnly />
                </div>

                <br />
              </div>
            )
          })}
      </div>

      <div
        className={css`
          width: 100%;
          display: flex;
          margin-top: 10px;
          justify-content: center;
        `}
      >
        <Pagination
          value={currentPage}
          onChange={setCurrentPage}
          total={totoalPage}
          className={css`
            margin: 'auto';
          `}
        />
      </div>
    </>
  )
}
