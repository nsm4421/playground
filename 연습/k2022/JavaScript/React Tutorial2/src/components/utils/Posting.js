import * as React from 'react';
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
import WriteMention from './WriteMention';
import SeeMentions from './SeeMentions';
import DeleteArticlePopUp from './DeleteArticlePopUp';

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


// 신고접수된 글인경우 빨간색
function IsReported(props){
    return(
        <div>
            {
                props.isReported
                ?
                    <Avatar sx={{bgcolor:red[500]}} aria-label="recipe">
                        Y
                    </Avatar>
                :
                    <Avatar sx={{bgcolor:blue[500]}} aria-label="recipe">
                        N
                    </Avatar>
            }
        </div>
    )
}


export default function Posting(props) {

  const [expanded, setExpanded] = useState(false);
  const [openDeleteModal, setOpenDeleteModal] = useState(false);

  return (

    <div>

      {/* 게시물 삭제 팝업 */}
     {
        openDeleteModal
        ? <DeleteArticlePopUp _id={props._id} title={props.posting.title} openDeleteModal={openDeleteModal} setOpenDeleteModal={setOpenDeleteModal}/>
        : null
      }

      <Card sx={{ maxWidth: "100%" }}>
        
        <CardHeader
          // 좋아요가 10개 이상이면 인기글
          avatar={
              <IsReported isReported={props.posting.isReported}/>
          }
          // 삭제
          action={
            <IconButton aria-label="settings">
              <div onClick={()=>{setOpenDeleteModal(true)}}>
                <ClearSharp/>
              </div>
            </IconButton>
          }

          // 글제목
          title={props.posting.title?props.posting.title:"글제목"}
          
          // 글쓴이 
          subheader={props.posting.writer?props.posting.writer:"karma"}
        />

        {/* 본문 */}
        <CardContent className='Introduction'>
          <Typography variant="h5" color="text.secondary">
              {props.posting.article?props.posting.article:"No mention"}
          </Typography>
        </CardContent>

          <CardActions disableSpacing>

          <span className='TimeWritted'>{`작성일자 : ${props.posting.writeAt}`}</span>
      
          {/* 댓글 보기 버튼 */}
            <ExpandMore
              expand={expanded}              
              aria-expanded={expanded}
              onClick={()=>{setExpanded(!expanded)}}
              aria-label="show more">             

              
              <ExpandMoreIcon />
            </ExpandMore>
        </CardActions>

        {/* 댓글 */}
        <Collapse in={expanded} timeout="auto" unmountOnExit>

          {/*  댓글쓰기 */}
          <WriteMention _id={props._id}/>

          {/* 댓글보기 */}
          <SeeMentions mentions={props.posting.mentions}/>

        </Collapse>

      </Card>

      <hr/>

    </div>
  );
}


