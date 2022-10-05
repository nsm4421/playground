import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import { FiBox } from '@react-icons/all-files/fi/FiBox';

const NavBar = ({username}) => {

  return (
      <Navbar bg="light" expand="lg">
      <Container>
        <Navbar.Brand href="#home"> <FiBox/> Hip Box</Navbar.Brand>
        
        <Navbar.Toggle/>
        <Navbar.Collapse>
          <Nav className="me-auto">

            <Nav.Link href="/">홈화면</Nav.Link>
            <Nav.Link href="/register">회원가입</Nav.Link>
            {
              username
              ? <Nav.Link href="/logout">로그아웃</Nav.Link>
              : <Nav.Link href="/login">로그인</Nav.Link>
            }            

            <NavDropdown title="포스트">
              <NavDropdown.Item href="/post">게시글</NavDropdown.Item>
              <NavDropdown.Item href="/post/write">쓰기</NavDropdown.Item>
            
            <NavDropdown.Divider />
              <NavDropdown.Item href="/post/my-post">내가 쓴 글</NavDropdown.Item>
            </NavDropdown>
            
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default NavBar;