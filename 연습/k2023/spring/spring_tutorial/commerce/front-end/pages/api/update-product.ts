import type { NextApiRequest, NextApiResponse } from 'next'
import axios from 'axios'

async function updateProduct(id:Number, description:String) {
  try {
    const endPoint = "http://localhost:8080/api/product"
    const data = {id, description}
    const res = await axios.put(endPoint, data)
    console.debug(res);
    return res.data;
  } catch (e) {
    console.error(JSON.stringify(e))
  }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    const { id, description } = JSON.parse(req.body);
    await updateProduct(id ,description)
    .then(()=>{
      res.status(200).json({ message: 'Update item success'})
    })
    .catch((err)=>{
      res.status(500).json({message:'Fail to update item'})
      console.error(err);
    })    
  } catch (e) {     
    console.error(e)
    return res.status(400).json({ message: 'Fail to update item' })
  }
}
