import * as React from 'react';
import Box from '@mui/material/Box';
import BottomNavigation from '@mui/material/BottomNavigation';
import BottomNavigationAction from '@mui/material/BottomNavigationAction';

export default function MyBottomNavbar(props) {

  return (
    <Box sx={{ width: "100%" }}>
      <BottomNavigation
        showLabels
        value={props.tab}
        onChange={(event, newtab) => {
          props.setTab(newtab);
        }}
      >
        <BottomNavigationAction label="홈화면"/>
        <BottomNavigationAction label="인기영화 Top20"/>
        <BottomNavigationAction label="영화검색"/>

      </BottomNavigation>
    </Box>
  );
}
