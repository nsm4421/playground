import Head from 'next/head'
import Products from './products'
import MyGoogleSignUp from '../components/googleLogin'

export default function Home() {

  return (
    <>
      <Head>
        <title>Commerce</title>
        <meta name="description" content="Commerce" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icons" href="/favicon.ico" />
        </Head>
        <MyGoogleSignUp/>
      <Products/>
    </>
  )
}
