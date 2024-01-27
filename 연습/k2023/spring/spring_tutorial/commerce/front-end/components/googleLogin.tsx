import { CredentialResponse, GoogleLogin } from '@react-oauth/google'

export default function MyGoogleSignUp() {
  const handleSuccess = (credentialResponse: CredentialResponse): void => {
    const endPoint = `/api/auth/google-sign-up?credential=${credentialResponse.credential}`
    fetch(endPoint)
      .then(res => res.json())
      .then((data) => {
        console.log(data)
      })
  }
  const handleError = () => {
    console.error('error')
  }

  return (
    <GoogleLogin onSuccess={handleSuccess} onError={handleError}></GoogleLogin>
  )
}
