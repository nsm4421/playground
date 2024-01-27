import type { NextApiRequest, NextApiResponse } from 'next'
import axios from 'axios'
import productModel from 'constant/productModel'

type Data = {
  message: String
  items: {
    content: productModel[]
    pageable: any
    totalElements: Number
    totalPages: Number
  }[]
}

async function getProducts({
  page,
  category,
  sort,
  keyword,
  searchType,
}: {
  page: Number
  category: String
  sort: String
  keyword: String
  searchType: String
}) {
  // construct end point
  const endPoint =
    'http://localhost:8080/api/product?page=' +
    (page ? `${Number(page) - 1}` : 0) +
    (sort ? `&sort=${sort}` : '') +
    (category !== 'ALL' ? `&category=${category}` : '') +
    (searchType && keyword
      ? `&searchType=${searchType}&keyword=${keyword}`
      : '')
  console.debug(endPoint)

  // axios
  try {
    const res = await axios.get(endPoint)
    return res.data
  } catch (e) {
    console.error(JSON.stringify(e))
  }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const { page, category, sort, keyword, searchType } = JSON.parse(req.body)
  try {
    const items = await getProducts({
      page,
      category,
      sort,
      keyword,
      searchType,
    })
    res.status(200).json({ message: 'Get item success', items: items })
  } catch (e) {
    console.error(e)
    return res.status(400).json({ message: 'Fail to get item', items: [] })
  }
}
