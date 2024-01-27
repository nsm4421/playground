import { styled } from '@mui/material/styles';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Badge from '@mui/material/Badge';
import MenuItem from '@mui/material/MenuItem';
import Menu from '@mui/material/Menu';
import AccountCircle from '@mui/icons-material/AccountCircle';
import MailIcon from '@mui/icons-material/Mail';
import NotificationsIcon from '@mui/icons-material/Notifications';
import MoreIcon from '@mui/icons-material/MoreVert';
import { Button } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { useRecoilState } from 'recoil';
import { userState } from '..';



const StyledNavBox = styled('div')(({ theme }) => ({
    position: 'relative',
    borderRadius: theme.shape.borderRadius,
    marginRight: theme.spacing(2),
    marginLeft: 0,
    width: '100%',
    [theme.breakpoints.up('sm')]: {
        marginLeft: theme.spacing(3),
        width: 'auto',
    },
}));

export default function Nav() {

    const [user, setUser] = useRecoilState(userState);
    const [isLogin, setIsLogin] = useState(false);
    const navigator = useNavigate();
    const [anchorEl, setAnchorEl] = useState(null);
    const [mobileMoreAnchorEl, setMobileMoreAnchorEl] = useState(null);
    const mobileMenuId = 'primary-search-account-menu-mobile';

    // 네비게이션 아이템
    const navItems = [
        { label: '홈', href: '/', showOnLogin: true, showOnNotLogin: true },
        { label: '회원가입', href: '/register', showOnLogin: false, showOnNotLogin: true },
        { label: '로그인', href: '/login', showOnLogin: false, showOnNotLogin: true },
        // TODO : 로그아웃시 로그아웃 처리 및 쿠키 clear
        { label: '로그아웃', href: '/logout', showOnLogin: true, showOnNotLogin: false},
        { label: '게시글', href: '/article', showOnLogin: true, showOnNotLogin: true },
    ]

    // user(전역변수) 변경 시 로그인 여부 갱신하기
    useEffect(() => {
        user.nickname ? setIsLogin(true) : setIsLogin(false);
    }, [user])

    const isMenuOpen = Boolean(anchorEl);
    const isMobileMenuOpen = Boolean(mobileMoreAnchorEl);

    const handleNav = (href) => (e) => {
        navigator(href);
    }

    const handleProfileMenuOpen = (event) => {
        setAnchorEl(event.currentTarget);
    };

    const handleMobileMenuClose = () => {
        setMobileMoreAnchorEl(null);
    };

    const handleMobileMenuOpen = (event) => {
        setMobileMoreAnchorEl(event.currentTarget);
    };

    const NavItems = () => {
        return (
            <StyledNavBox>
                {
                    navItems.map((n, i) => {
                        const show = (isLogin && n.showOnLogin) || (!isLogin && n.showOnNotLogin)
                        return show ? <Button sx={{ color: 'white' }} key={i} onClick={handleNav(n.href)}>{n.label}</Button> : null
                    })
                }
            </StyledNavBox>
        )
    }

    const menuId = 'primary-search-account-menu';

    const RightSideIconsOnWideView = () => {
        return isLogin ?
            <Box sx={{ display: { xs: 'none', md: 'flex' } }}>
                <IconButton size="large" aria-label="show 4 new mails" color="inherit">
                    <Badge badgeContent={4} color="error">
                        <MailIcon />
                    </Badge>
                </IconButton>
                <IconButton
                    size="large"
                    aria-label="show 17 new notifications"
                    color="inherit"
                >
                    <Badge badgeContent={17} color="error">
                        <NotificationsIcon />
                    </Badge>
                </IconButton>
                <IconButton
                    size="large"
                    edge="end"
                    aria-label="account of current user"
                    aria-controls={menuId}
                    aria-haspopup="true"
                    onClick={handleProfileMenuOpen}
                    color="inherit"
                >
                    <AccountCircle />
                    <Typography sx={{ ml: 1 }}>{user.nickname}</Typography>
                </IconButton>
            </Box>
            : null

    }

    const RightSideIconsOnNarrowView = () => {
        return isLogin ?
            <Menu
                anchorEl={mobileMoreAnchorEl}
                anchorOrigin={{
                    vertical: 'top',
                    horizontal: 'right',
                }}
                id={mobileMenuId}
                keepMounted
                transformOrigin={{
                    vertical: 'top',
                    horizontal: 'right',
                }}
                open={isMobileMenuOpen}
                onClose={handleMobileMenuClose}
            >
                <MenuItem>
                    <IconButton size="large" aria-label="show 4 new mails" color="inherit">
                        <Badge badgeContent={4} color="error">
                            <MailIcon />
                        </Badge>
                    </IconButton>
                    <p>Messages</p>
                </MenuItem>
                <MenuItem>
                    <IconButton
                        size="large"
                        color="inherit"
                    >
                        <Badge badgeContent={17} color="error">
                            <NotificationsIcon />
                        </Badge>
                    </IconButton>
                    <p>Notifications</p>
                </MenuItem>
                <MenuItem onClick={handleProfileMenuOpen}>
                    <IconButton
                        size="large"
                        color="inherit"
                    >
                        <AccountCircle />
                    </IconButton>
                    <p>{user.nickname}</p>
                </MenuItem>
            </Menu>
            : null
    };

    return (
        <Box sx={{ flexGrow: 1 }}>
            <AppBar position="static">
                <Toolbar>

                    {/* 앱 로고 */}
                    <Typography
                        variant="h6"
                        noWrap
                        component="div"
                        sx={{ display: { xs: 'none', sm: 'block' } }}
                        onClick={handleNav("/")}
                    >
                        Karma
                    </Typography>

                    {/* 네비게이션 아이템 */}
                    <NavItems />


                    {/* 오른쪽 아이콘 메뉴 */}
                    <Box sx={{ flexGrow: 1 }} />
                    <RightSideIconsOnWideView />

                    <Box sx={{ display: { xs: 'flex', md: 'none' } }}>
                        <IconButton
                            size="large"
                            aria-label="show more"
                            aria-controls={mobileMenuId}
                            aria-haspopup="true"
                            onClick={handleMobileMenuOpen}
                            color="inherit"
                        >
                            <MoreIcon />
                        </IconButton>
                    </Box>
                </Toolbar>
            </AppBar>

            {/* 화면이 줄어들었을 때 오른쪽 아이콘 메뉴 대신 보여줄 메뉴 */}
            <RightSideIconsOnNarrowView />
        </Box>
    );
}