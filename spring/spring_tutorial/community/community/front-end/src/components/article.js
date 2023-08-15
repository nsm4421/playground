import { styled } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import CardMedia from '@mui/material/CardMedia';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Collapse from '@mui/material/Collapse';
import Avatar from '@mui/material/Avatar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import { red } from '@mui/material/colors';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import CreateIcon from '@mui/icons-material/Create';
import { useState } from 'react';
import { Delete, PendingTwoTone, TagSharp, ThumbDown, ThumbUp } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';
import { deleteArticleApi } from '../api/articleApi';
import Comment from './comment';
import { Chip } from '@mui/material';

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

export default function RecipeReviewCard(props) {
    const navigator = useNavigate();
    const [expanded, setExpanded] = useState(false);

    const handleNav = (href) => () => {navigator(href)};
    const handleClickLike = () => { }
    const handleClickDislike = () => { }
    const handleExpandClick = () => {
        setExpanded(!expanded);
    };

    const handleDeleteArticle = async () => {
        props.setIsLoading(true);
        await deleteArticleApi(
            props.article.articleId, 
            // 삭제 성공 시
            ()=>{
                window.location.href = '/article';
            }, 
            // 삭제 실패시
            (err)=>{
                alert("게시글 삭제 실패");
                console.log(err);
        });
        props.setIsLoading(false);
    }

    return (
        <Card sx={{ maxWidth: '100' }}>

            <CardHeader
                avatar={
                    // TODO : 프로필 사진 가져오기
                    <Avatar sx={{ bgcolor: red[500] }} aria-label="recipe">
                        R
                    </Avatar>
                }
                action={
                    // TODO : 자기가 작성한 게시글만 삭제할 수 있도록 하기
                    <div>
                        <IconButton onClick={handleNav(`/article/modify/${props.article.articleId}`)}>
                            <CreateIcon />
                        </IconButton>
                        <IconButton onClick={handleDeleteArticle}>
                            <Delete />
                        </IconButton>
                    </div>
                }
                title={props.article.title}
                subheader={props.article.createdAt}
            />

            {/* 이미지 */}
            {
                props.article.images
                    ? 
                    props.article.images.map((img, i) => {
                        return (
                            <CardMedia
                                key = {i}
                                component="img"
                                height="194"
                                image={img}
                                alt="Paella dish"/>
                        )
                    })
                    : null
            }
            
            <CardContent>

                {/* 제목 */}
                <Typography sx={{mb:3}}>
                    {props.article.title}
                </Typography>

                {/* 본문 */}
                <Typography variant="body2" sx={{mb:5}}>
                    {props.article.content}
                </Typography>


                {/* 해시태그 */}
                {
                    props.article.hashtags.filter((v, _, __) => {
                        return v.trim() != ""
                    }).length > 0 ?
                        props.article.hashtags.map((h, i) => {
                            return (
                                <Chip
                                    key={i}
                                    label={h}
                                    avatar={<TagSharp />}
                                />
                            )
                        })
                        : null
                }
            </CardContent>

            {/* 감정표현 */}
            {/* TODO : 감정표현 개수 표시 */}
            <CardActions disableSpacing>
                {/* 좋아요 */}
                <IconButton onClick={handleClickLike}>
                    <ThumbUp />
                </IconButton>
                {/* 싫어요 */}
                <IconButton onClick={handleClickDislike}>
                    <ThumbDown />
                </IconButton>

                <ExpandMore
                    expand={expanded}
                    onClick={handleExpandClick}
                    aria-expanded={expanded}>
                    <ExpandMoreIcon />
                </ExpandMore>
            </CardActions>

            <Collapse in={expanded} timeout="auto" unmountOnExit>
                <CardContent>
                    <Comment articleId={props.article.articleId}/>
                </CardContent>
            </Collapse>
        </Card>
    );
}