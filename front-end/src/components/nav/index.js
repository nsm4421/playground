import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom'
import KeyboardArrowDownIcon from '@mui/icons-material/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import './index.css'

const Index = () => {

    const navigator = useNavigate();
    const [selected, setSelected] = useState(0);
    const [showMenus, setShowMenus] = useState(true);

    const navList = [
        {label:"홈", href:"/"},
        {label:"회원가입", href:"/register"},
        {label:"로그인", href:"/login"},
        {label:"로그아웃", href:"/logout"},
        {label:"채팅방", href:"/chats"},
    ]

    const handleClick = (i) => (e) => {
        e.preventDefault();
        setSelected(i);
        navigator(navList[i].href);
    }

    const handleToggle = (e) => {
        e.preventDefault();
        setShowMenus(!showMenus)
    }

    const handleResize = (e) => {
        if (window.innerWidth>=768){
            setShowMenus(true);
        }
    }

    useEffect(()=>{
        window.addEventListener('resize', handleResize);
        return ()=>{
            window.removeEventListener('resize', handleResize);
        }
    }, [])

    return (
        <nav className='container'>
            <h1><a href='/'>Karma</a></h1>
            <ul className='nav-list'>
                {
                    navList.map((n, i)=>{
                        return (
                            <li key={i} hidden={!showMenus}>
                                <a href={n.href} onClick={handleClick(i)} className={selected === i ? 'selected' : 'not-selected'}>{n.label}</a>
                            </li>
                        );
                    })
                }
            </ul>
            <li className='toggle-btn' onClick={handleToggle}>
                {
                    showMenus
                    ?<KeyboardArrowUpIcon/>
                    :<KeyboardArrowDownIcon/>
                }
            </li>
        </nav>
    );
}
export default Index;