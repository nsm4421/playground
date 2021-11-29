import {Offcanvas, Button, Nav} from 'react-bootstrap'
import useState from 'react'


function Navbar(props){
    return (
<>
<Nav className="navbar" justify variant="tabs" defaultActiveKey="/">
    
    <Nav.Item className="navbar-item">
    <Nav.Link href="/home">Home</Nav.Link>
    </Nav.Item>

    <Nav.Item  className="navbar-item">
    <Nav.Link href="/home">취업공고</Nav.Link>
    </Nav.Item>

    <Nav.Item  className="navbar-item">
    <Nav.Link href="/home">익명게시판</Nav.Link>
    </Nav.Item>

</Nav>
</>
    )
}



export default Navbar;