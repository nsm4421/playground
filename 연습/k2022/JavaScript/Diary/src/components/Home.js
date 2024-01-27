import DeleteDiary from '../api/DeleteDiary';
import { useState, useEffect } from 'react';
import { styled } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Collapse from '@mui/material/Collapse';
import Avatar from '@mui/material/Avatar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import { red, blue } from '@mui/material/colors';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { ClearSharp } from '@mui/icons-material';
import PublishedWithChangesIcon from '@mui/icons-material/PublishedWithChanges';
import { Tooltip } from "@mui/material";
import { Button } from "@mui/material";

const ExpandMore = styled((props) => {
  const { expand, ...other } = props;
  return <IconButton {...other} />;
})(({ theme, expand }) => ({
  transform: !expand ? 'rotate(0deg)' : 'rotate(180deg)',
  marginLeft: 'auto',
  transition: theme.transitions.create('transform', {
    duration: theme.transitions.duration.shortest,
  }),
}));

const ChangeAvatar = ()=>{
    return (
        <Tooltip title="수정하기">
            <Avatar sx={{bgcolor:blue[300], '&:hover':{bgcolor:'orange'}}}>
                <PublishedWithChangesIcon/>
            </Avatar>            
        </Tooltip>
    )
}

const DeleteButton = ({title, _id, loadData})=>{

    const handleDelete = ()=>{
        DeleteDiary(_id);
        alert(`일기 ${title}가 삭제되었습니다.`)
        loadData()
    }

    return (
        <Tooltip title="삭제하기">
            <Avatar sx={{bgcolor:blue[200], '&:hover':{bgcolor:'orange'}}}
                onClick={()=>{handleDelete()}}>
                <ClearSharp/>
            </Avatar>            
        </Tooltip>
    )
}

const Content = ({title, imgSrc})=>{
    return (
        <>
            {
                imgSrc
                ?
                <CardContent sx={{display:'flex', flexDirection:'row', flexGrow:1, justifyContent:'space-around', alignItems:'center'}}>
                    <Typography variant="h5" color="white">
                    {title}
                    </Typography>
                    <img src={imgSrc}></img>
                </CardContent>
                :
                <CardContent sx={{display:'flex', flexDirection:'row', flexGrow:1, justifyContent:'space-around', alignItems:'center'}}>
                    <Typography variant="h5" color="white">
                    {title}
                    </Typography>
            </CardContent>
            }
        </>
    )
}

const Record = ({_id, diary, diaryList, setDiaryList, loadData}) => {

  const [expanded, setExpanded] = useState(false);
  
  return (

    <div style={{width:'100%', padding:'10px', borderRadius:'30%'}}>

      <Card sx={{ maxWidth: "90%" , color:'white', background:"#00101d"}}>

        <CardHeader      
            // 글 수정 버튼
            avatar={<ChangeAvatar _id={_id}/>}
            // 글 삭제 버튼
            action={<DeleteButton _id={_id} title={diary.title} loadData={loadData}/>}
            // 작성일자
            title={diary.writeAt} 
            />

        {/* 본문 - 제목 + 썸네일*/}
        <Content title={diary.title} imgSrc={diary.imgSrc}/>
    
        <CardActions disableSpacing>
      
        {/* 토글링 */}
        <ExpandMore
            expand={expanded}              
            aria-expanded={expanded}
            onClick={()=>{setExpanded(!expanded)}}
            sx={{bgcolor: blue[200], color:'white-smoke', '&:hover':{bgcolor:'orange'}}}>           
            <ExpandMoreIcon />
        </ExpandMore>
    
        </CardActions>
        <hr/>

        {/* 댓글 */}
        <Collapse in={expanded} timeout="auto" unmountOnExit>
            <div style={{color:'white', padding:'10px', }}>
                {diary.article}    
            </div>
        </Collapse>

      </Card>
 
    </div>
  );
}

const Home = ({setTab, diaryList, setDiaryList, loadData})=>{

    return (
        <div style={{marginBottom:'20px'}}>
        {
            diaryList
            ?
                <div style={{display:'grid', gridTemplateColumns: '1fr 1fr'}}>
                    {
                        Object.keys(diaryList).map((k, i)=>{
                            return (
                                <Record key={i} _id={k} diary={diaryList[k]} setDiaryList={setDiaryList} loadData={loadData}/>
                            )
                        })
                    }                    
                </div>
            :
            <div>
                <h1 style={{margin:'20px'}}>등록된 글이 없습니다.</h1>
                <Button variant="outlined" 
                sx={{margin:'30px', color: 'black', bgcolor:'skyblue', '&:hover':{bgcolor:'orange'}}}
                onClick={()=>{setTab(1)}}>
                    글쓰러 가기
                </Button>
            </div>
        }
    
        </div> 
    )
}


export default Home;