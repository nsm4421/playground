import './Nav.css'
import { getAuth, signOut } from "firebase/auth";
import app from '../../api/App';
import { Link } from 'react-router-dom';

const auth = getAuth(app);

const Logo = ({logoPath}) => {
 
    return (
        <div className='nav__logo'>
            <img src={logoPath}/>
            <h3><Link to="/">Karma</Link></h3>
        </div>
    )
}

const AuthBanner = ({logined})=>{

    if (logined){
        return (
            <ul className='nav__banner' onClick={()=>{Logout()}}>
                <li><Link to="/">Logout</Link></li>
                <li><Link to="/writting">writting</Link></li>
            </ul>
        )
    } else {
        return (
            <ul className='nav__banner'>             
                <li><Link to="/writting">writting</Link></li>
                <li><Link to="/login">Login</Link></li>
                <li><Link to="/register">Register</Link></li>
            </ul>
        )
    }
}

const Logout = ()=>{  
    signOut(auth).then(() => {
        console.log("logout")
        localStorage.removeItem('karma-user')
    }).catch((e) => {
        console.log(e)
    })  
}

const Nav = ({logined})=>{

    const logoPath = `${process.env.PUBLIC_URL}/logo.svg`
      
    return (
        <div className='nav__container'>
            
            <Logo logoPath = {logoPath}/>
            
            <AuthBanner logined={logined}/>

        </div>
    )
}

export default Nav;