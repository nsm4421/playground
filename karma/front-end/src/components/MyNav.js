import styled from 'styled-components';
import { useEffect, useState } from 'react';
import { Navbar, Container, Nav} from 'react-bootstrap'
import { useNavigate } from 'react-router-dom';


const links = [
    {
        LABEL:"Home",
        HREF:"/"
    },
    {
        LABEL:"Feed",
        HREF:"/feed"
    },
    {
        LABEL:"Register",
        HREF:"/register"
    },
    {
        LABEL:"Login",
        HREF:"/login"
    },
    {
        LABEL:"PAGE4",
        HREF:"/page4"
    },
  ]
  

const MyNav = () => {

    const [selected, setSelected] = useState(0);
    const navigator = useNavigate();

    const handleClick = (i) => (e)=>{
        e.preventDefault();
        setSelected(i);
        navigator(links[i].HREF);
    }

    useEffect(()=>{
        const currentHref = window.location.href;
        links.map((l, i)=>{
            if (currentHref.toUpperCase().includes(l.HREF.toUpperCase())){
                setSelected(i);
            }
        })
    }, [])

    return (
        <div>
        <Navbar bg="dark" variant="dark">
            <Container>
            <Navbar.Brand href="#" className='text-warning'>Karma</Navbar.Brand>
            <Nav className="me-auto">
                {
                    links.map((l, i)=>{
                        return (
                            <Nav.Link 
                                onClick={handleClick(i)}
                                className={i === selected ? 'text-white' : 'text-secondary'}
                                key={i} href={l.HREF}>{l.LABEL}
                            </Nav.Link>
                        )
                    })
                }
            </Nav>
            </Container>
        </Navbar>
        </div>
  )
}

export default MyNav