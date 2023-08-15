import 'styles/globals.css'
import type { AppProps } from 'next/app'
import { GoogleOAuthProvider } from '@react-oauth/google'
import { CLIENT_ID } from 'constant/googleAuth'

export default function App({ Component, pageProps }: AppProps) {
  return (
    <GoogleOAuthProvider clientId={CLIENT_ID}>
      <Component {...pageProps} />
    </GoogleOAuthProvider>
  )
}
