import type { NextApiRequest, NextApiResponse } from 'next'
import axios from 'axios'

type Data = {
  message : String,
  items : Map<String,String>[]|undefined
}

async function getCategory() {
  try {
    const endPoint = 'http://localhost:8080/api/product/category'
    const res = await axios.get(endPoint)
    return res.data;
  } catch (e) {
    console.error(JSON.stringify(e))
  }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  try {
    const items = await getCategory()
    res.status(200).json({ message: 'Get categories', items: items })
  } catch (e) {     
    console.error(e)
    return res.status(400).json({ message: 'Fail to get cactegories', items:undefined})
  }
}
