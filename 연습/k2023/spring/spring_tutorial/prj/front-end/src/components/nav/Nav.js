import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import MenuItem from '@mui/material/MenuItem';
import AdbIcon from '@mui/icons-material/Adb';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import { Link } from 'react-router-dom';
import { useRecoilState } from 'recoil';
import { userState } from '../../recoil/user';
import { useEffect, useState } from 'react';
import axios from 'axios';
import { Tooltip } from '@mui/material';

// Custom Settings
const appName = "Karma"
const pagesNotLogined = [
  {label:"register", link:"/register"},
  {label:"login", link:"/login"},
]

const pagesLogined = [
  {label:"post", link:"/post"},
  {label:"logout", link:"/logout"}
]

// Icon Button
const IconBtn = ({nickname}) => {

  if (nickname){
    return (
      <Tooltip title="마이페이지">
        <Box sx={{ flexGrow: 0, alignItems:"center"}}>    
            <Link to="/mypage">
              <IconButton sx={{color:"white", fontSize:'1vw', display:"flex"}}>
                <AccountCircleIcon sx={{marginRight:"10px"}}/>
                <Typography variant='span'>{nickname}</Typography>
              </IconButton>
            </Link> 
        </Box>
      </Tooltip>
    );
  };
}

// Component to export
const Nav = () => {
  const [user, setUser] = useRecoilState(userState);
  const [pages, setPages] = useState([{}]);
  const [anchorElNav, setAnchorElNav] = useState(null);

  useEffect(()=>{
    // localStorage에서 token값 꺼내기
    const token = localStorage.getItem("token");
    // token이 없으면 초기화
    if (!token){
      setPages(pagesNotLogined);
      setUser({nickname:null, token: null});
      localStorage.removeItem("token");
      return;
    }    
    // token이 유효한지 요청
    const endPoint = "/api/v1/user/nickname";
    axios.get(endPoint, {
      headers:{
        Authorization : localStorage.getItem("token")
      }
    }).then((res)=>{
      return res.data.result
    }).then((nickname)=>{
      setPages(pagesLogined);
      setUser({token, nickname});
    }).catch((err)=>{
      localStorage.removeItem("token");   // 기존 토큰으로 로그인 실패시 토큰 제거
      console.log(err);
    })
  }, [])

  const handleOpenNavMenu = (event) => {
    setAnchorElNav(event.currentTarget);
  };
  const handleCloseNavMenu = () => {
    setAnchorElNav(null);
  };

  return (
    <AppBar position="static">
      <Container maxWidth="xl">
        <Toolbar disableGutters>
          <AdbIcon sx={{ display: { xs: 'none', md: 'flex' }, mr: 1 }} />
          <Link to="/">
            <Typography
              variant="h6"
              noWrap
              sx={{
                mr: 2,
                display: { xs: 'none', md: 'flex' },
                fontFamily: 'monospace',
                fontWeight: 700,
                letterSpacing: '.3rem',
                color: 'white',
                textDecoration: 'none',
              }}>
              {appName}
            </Typography>
          </Link>

          <Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}>
            <IconButton
              size="large"
              aria-label="account of current user"
              aria-controls="menu-appbar"
              aria-haspopup="true"
              onClick={handleOpenNavMenu}
              color="inherit"
            >
            <MenuIcon />
            </IconButton>
            <Menu
              id="menu-appbar"
              anchorEl={anchorElNav}
              anchorOrigin={{
                vertical: 'bottom',
                horizontal: 'left',
              }}
              keepMounted
              transformOrigin={{
                vertical: 'top',
                horizontal: 'left',
              }}
              open={Boolean(anchorElNav)}
              onClose={handleCloseNavMenu}
              sx={{
                display: { xs: 'block', md: 'none' },
              }}
            >
              {pages.map((page, idx) => (
                <Link to={page.link} key={idx}>
                  <MenuItem onClick={handleCloseNavMenu}>
                    <Typography textAlign="center">{page.label}</Typography>
                  </MenuItem>
                </Link>
              ))}
            </Menu>
          </Box>
          <AdbIcon sx={{ display: { xs: 'flex', md: 'none' }, mr: 1 }} />
          <Typography
            variant="h5"
            noWrap
            component="a"
            href=""
            sx={{
              mr: 2,
              display: { xs: 'flex', md: 'none' },
              flexGrow: 1,
              fontFamily: 'monospace',
              fontWeight: 700,
              letterSpacing: '.3rem',
              color: 'inherit',
              textDecoration: 'none',
            }}
          >
            {appName}
          </Typography>

          <Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' } }}>
            {pages.map((page, idx) => (
              <Link key={idx} to={page.link} sx={{color: 'white'}}>
                <Button                  
                  onClick={handleCloseNavMenu}
                  sx={{ my: 2, color: 'white', display: 'block' }}>
                  {page.label}
                </Button>
              </Link>
            ))}
          </Box>
          
          {/* 아이콘 버튼 */}
          <IconBtn nickname={user.nickname}/>
        </Toolbar>
      </Container>
    </AppBar>
  );
}
export default Nav;