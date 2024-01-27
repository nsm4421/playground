import { AppBar, InputBase, TextField, Tooltip } from "@mui/material";
import { Button } from "@mui/material";
import { IconButton } from "@mui/material";
import { Box } from "@mui/system";
import { Typography } from "@mui/material";
import CloudQueueIcon from '@mui/icons-material/CloudQueue';
import BottomNavigation from '@mui/material/BottomNavigation';
import BottomNavigationAction from '@mui/material/BottomNavigationAction';
import HomeIcon from '@mui/icons-material/Home';
import CollectionsIcon from '@mui/icons-material/Collections';
import CreateIcon from '@mui/icons-material/Create';
import SettingsIcon from '@mui/icons-material/Settings';
import { useState } from "react";

const HeaderDeco = ()=>{
    return (
        <div style={{display:'flex', float:'left', justifyContent:'center', alignItems:'center',
            padding:'10px', }}>
            <IconButton edge="start" color="inherit" aria-label="menu" sx={{ mr: 2 }}>
                <CloudQueueIcon/>
            </IconButton>

            <Typography variant="h6" color="inherit" component="div">
                My Diary
            </Typography>
        </div>
    )
}


const SearchBar = ({search, setSearch, diaryList, setDiaryList, loadData})=>{

    const handleSearch = ()=>{
        const newDiaryList = {}
        console.log(Object.keys(diaryList))
        Object.keys(diaryList).map((k, i)=>{
            if (diaryList[k].title.includes(search)){
                newDiaryList[k] = {...diaryList[k]}
            }
        })        
        if (newDiaryList === {}){
            alert('일치하는 자료가 없습니다.')
            setSearch("")
        } else {
            setDiaryList(newDiaryList)
        }
    }

    return (
        <div style={{float:'right', marigin:'10px', padding:'10px'}}>
                        
            <input type="text" list="title-option"
                style={{height:'100%', width:'200px'}}
                onChange={(e)=>{setSearch(e.target.value)}}
                />
            
            <Button sx={{color:'white', marginLeft:'20px'}}
                onClick={handleSearch} placeholder="제목으로 찾으세요">
                필터걸기
            </Button>
            <Button sx={{color:'white', marginLeft:'20px'}}
                onClick={loadData}>
                필터해제
            </Button>

            {/* 자동완성 기능 */}
            <datalist id="title-option">
                {
                    Object.keys(diaryList).map((k, i)=>{
                        return (
                            <option key={i}>{diaryList[k].title}</option>
                        )
                    })
                }
            </datalist>       
        </div>
    )
}


const BottomNav = ({tab, setTab}) =>{

    return (
        <BottomNavigation
            sx = {{bgcolor:'#fff', position:'fixed', bottom:'0', width:'100%', background: '#fff'}}
            showLabels
            value={tab}
            onChange={(_, e) => {setTab(e)}}>
 
            <BottomNavigationAction label="Home" icon={<HomeIcon />}/>
            <BottomNavigationAction label="Diary" icon={<CreateIcon />}/>
            <BottomNavigationAction label="Pictures" icon={<CollectionsIcon />} />
            <BottomNavigationAction label="Setting" icon={<SettingsIcon />} />
        </BottomNavigation>
    );
  }


const MyAppBar = ({tab, setTab, diaryList, setDiaryList, loadData})=>{

    const [search, setSearch] = useState("");

    return (
        
    <Box sx={{ flexGrow: 1, marginBottom:'60px'}}>
        <AppBar position="fixed" 
            sx={{ flexGrow: 1, background: '#005'}}>

            <div style={{display:'inline'}}>
                <HeaderDeco/>
                <SearchBar 
                    diaryList={diaryList} setDiaryList={setDiaryList} 
                    search={search} setSearch={setSearch} loadData={loadData}/>
            </div>

            <BottomNav tab={tab} setTab={setTab}/>
        
        </AppBar>
    </Box>
        
    )
}


export default MyAppBar;