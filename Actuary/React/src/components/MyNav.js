import {Nav, Navbar, Container, NavDropdown} from 'react-bootstrap';


export default function MyNav(){
    return (
        <>        
            <Navbar bg="light" expand="lg">
            <Container>
                <Navbar.Brand href="/">Karma</Navbar.Brand>
                <Navbar.Toggle aria-controls="basic-navbar-nav" />
                <Navbar.Collapse id="basic-navbar-nav">
                <Nav className="me-auto">
                    <Nav.Link href="/">홈</Nav.Link>
                    <NavDropdown title="메뉴" id="basic-nav-dropdown">
                    <NavDropdown.Item href="Qx">위험률</NavDropdown.Item>
                    <NavDropdown.Item href="ShowCoverage">담보정보</NavDropdown.Item>
                    <NavDropdown.Item href="Comb">결합위험률</NavDropdown.Item>
                    <NavDropdown.Divider />
                    <NavDropdown.Item href="Calc">계산</NavDropdown.Item>
                    </NavDropdown>
                </Nav>
                </Navbar.Collapse>
            </Container>
            </Navbar>
        </>
    )
};

