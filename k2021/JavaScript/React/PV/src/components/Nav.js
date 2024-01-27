import {React, useState} from 'react'
import {Nav} from 'react-bootstrap'


function Navbar() {

    return ( 
        <>
            <Nav>
            <Nav.Item>
                <Nav.Link>Home</Nav.Link>
            </Nav.Item>
            <Nav.Item>
                <Nav.Link>Qx</Nav.Link>
            </Nav.Item>
            <Nav.Item>
                <Nav.Link>담보정보</Nav.Link>
            </Nav.Item>
            <Nav.Item>
                <Nav.Link>담보추가</Nav.Link>
            </Nav.Item>
            <Nav.Item>
                <Nav.Link>사업비</Nav.Link>
            </Nav.Item>
            </Nav>
        </>
    )   
}



export default Navbar;
