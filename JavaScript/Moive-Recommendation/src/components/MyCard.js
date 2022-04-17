import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import { CardActionArea } from '@mui/material';
import GetImage from './utils/GetImage';
import CardHeader from '@mui/material/CardHeader';
import Avatar from '@mui/material/Avatar';
import IconButton from '@mui/material/IconButton';
import { red, blue } from '@mui/material/colors';
         

export default function MyCard(props) {
  return (
    <Card sx={{ maxWidth: "50%" }}>

        {/* Header */}
        <CardHeader
            // 성인물이면 빨간색으로 19, 아니면 파란색으로 <19
            avatar={
                <Avatar sx={props.adult?{bgcolor: red[600]}:{bgcolor:blue[600]}} aria-label="recipe">
                {props.adult?"19":"<19"}
                </Avatar>
            }

            action={
            <IconButton aria-label="settings">
            {/* <MoreVertIcon /> */}
            </IconButton>
            }
            title="찾는 영화가 이거 맞음?"
            subheader={props.date}
        />

      <CardActionArea>
        {/* 썸네일 */}
        <GetImage movie_id={props.movie_id} title={props.title}/>
        <CardContent>
            {/* 영화제목 */}
          <Typography gutterBottom variant="h5" component="div">
            {props.title}
          </Typography>
          {/* 줄거리 */}
          <Typography variant="body2" color="text.secondary">
            {props.overview}
          </Typography>
        </CardContent>
      </CardActionArea>
    </Card>
  );
}
