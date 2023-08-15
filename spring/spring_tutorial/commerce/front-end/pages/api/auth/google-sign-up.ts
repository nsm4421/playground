import type { NextApiRequest, NextApiResponse } from 'next'
import axios from 'axios'
import jwtDecode from 'jwt-decode'

type Data = {
  message : String,
}

type DecodedData = {
  aud:String,
  azp:String,
  email:String,
  email_verified:Boolean,
  exp: Number,
  family_name:String,
  given_name:String,
  iat:Number,
  iss:String,
  jti:String,
  name:String,
  nbf:Number,
  picture:String,
  sub:String
}

async function signUp(credential:string) {

    const decoded : DecodedData = jwtDecode(credential)
    const data = {
      username : `GOOGLE_${decoded.name}`,
      email :decoded.email,
      imgUrl : decoded.picture,
      password : null
    }

    try {
      await axios.post("http://localhost:8080/api/user/signUp", data)
      .then(console.log)
      
    } catch (err) {
      console.log(err);
    }
}

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
    const {credential} = req.query
  try {
    await signUp(String(credential))
    res.status(200).json({ message : 'Sign-in success'})
  } catch (e) {     
    console.error(e)
    return res.status(400).json({ message: 'Fail to login'})
  }
}
