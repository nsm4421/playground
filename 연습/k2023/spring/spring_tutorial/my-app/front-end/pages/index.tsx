import { Container } from '@mantine/core'
import Link from 'next/link'

export default function Home() {
  return (
    <Container>
      <h1>Portfilo</h1>
      <hr/>
        <h2>Front End</h2>
          <h3>Next JS</h3>
          <ul>
            <li>Sign Up Page</li>
            <li>Login Page</li>
            <li>App Bar</li>
            <li>Article Page</li>
            <li>Write Article Page</li>
            <li>Detail Page</li>
            <li>Notification Page</li>
          </ul>
      <hr/>
        <h2>Back End</h2>
          <h3>Spring Boot</h3>
          <ul>
            <li>Spring Boot</li>
            <li>JPA / JPQL</li>
            <li>Redis - Cashing for login user principal</li>
            <li>SSE / Kafa - Notification function</li>
          </ul>
      <hr/>
      <h2>Author</h2>
        <h3>상도동 카르마</h3>
        <ul>
          <li>(Blog) https://blog.naver.com/nsm4421</li>
          <li>(Git) https://github.com/nsm4421</li>
        </ul>
      <hr/>
    </Container>
  )
}
