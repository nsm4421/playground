import type { NextApiRequest, NextApiResponse } from 'next'
import axios from 'axios'
import productModel from 'constant/productModel'

// API response
type Data = {
  message : String,
  data : productModel| undefined
}

async function getProduct(id:number) {
  try {
    const endPoint = `http://localhost:8080/api/product/${id}`
    const res = await axios.get(endPoint)
    console.debug(res.data??res);
    return res;
  } catch (e) {
    console.error(JSON.stringify(e))
  }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  const { id } = req.query
  if (id == null){
    return res.status(400).json({ message: 'product id is not given', data : undefined })
  }
  try {
    const items = await getProduct(Number(id))
    res.status(200).json({ message: 'Get item success', data: items?.data })
  } catch (e) {     
    console.error(e)
    return res.status(400).json({ message: 'Fail to get item' , data : undefined})
  }
}
