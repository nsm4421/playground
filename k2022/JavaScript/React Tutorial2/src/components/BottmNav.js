import * as React from 'react';
import Box from '@mui/material/Box';
import BottomNavigation from '@mui/material/BottomNavigation';
import BottomNavigationAction from '@mui/material/BottomNavigationAction';
import HomeIcon from '@mui/icons-material/Home';
import AccountCircleIcon from '@mui/icons-material/AccountCircle';
import SettingsIcon from '@mui/icons-material/Settings';
import CreateIcon from '@mui/icons-material/Create';

export default function BottomNav(props) {

    // const [value, setValue] = React.useState(0);

  return (
    <div>
        <Box sx={{ width: 500 }} className="Navbar">
            <BottomNavigation
                showLabels
                value={props.tab}
                onChange={(event, newValue) => {
                    // setValue(newValue);
                    props.setTab(newValue);
                }}
            >
                <BottomNavigationAction label="홈" icon={<HomeIcon />} />
                <BottomNavigationAction label="글쓰기" icon={<CreateIcon />} />
                <BottomNavigationAction label="마이페이지" icon={<AccountCircleIcon />} />
                <BottomNavigationAction label="세팅" icon={<SettingsIcon />} />
            </BottomNavigation>
            </Box>
    </div>
  );
}