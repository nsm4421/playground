import { Chip, FormControl, FormHelperText, Grid, IconButton, InputAdornment, OutlinedInput, TextField, Typography, } from "@mui/material";
import TopicIcon from '@mui/icons-material/Topic';
import { Subtitles } from "@mui/icons-material";
import TagIcon from '@mui/icons-material/Tag';
import ControlPointIcon from '@mui/icons-material/ControlPoint';
import { Box } from "@mui/system";
import RemoveCircleOutlineIcon from '@mui/icons-material/RemoveCircleOutline';

export default function WriteArticleForm(props) {

    // TODO : 이미지 업로드 
    const handleTitle = (e) => { props.setTitle(e.target.value); };
    const handleContent = (e) => { props.setContent(e.target.value); };

    return (
        <div>
                       
            <Chip color="primary" icon={<TopicIcon />} label="제목" />
            <FormControl sx={{ m: 1 }} fullWidth>
                <OutlinedInput
                    value={props.title}
                    onChange={handleTitle}
                    placeholder="게시글 제목을 입력해주세요"
                />
                <FormHelperText> </FormHelperText>
            </FormControl>  

            <Chip color="primary" icon={<Subtitles />} label="본문" />
            <FormControl sx={{ m: 1 }} fullWidth>
                <OutlinedInput
                    multiline
                    value={props.content}
                    onChange={handleContent}
                    placeholder="본문을 입력해주세요"/>
                <FormHelperText> </FormHelperText>
            </FormControl>  
       
            <HashtagsForm hashtags={props.hashtags} setHashtags={props.setHashtags}/>

        </div>
    )
}

const HashtagsForm = (props) => {

    const MAX_HASHTAG = 5;                                  // 최대 해시태그 개수
    const handleHashtag = (i) => (e) => {
        const _hashtags = [...props.hashtags];
        _hashtags[i] = e.target.value.replace("#", "");      // #는 못쓰게 막기
        props.setHashtags(_hashtags);
    }
    const addHashtag = () => {
        if (props.hashtags.length < MAX_HASHTAG) {
            props.setHashtags([...props.hashtags, ""]);
        }
    }
    const deleteHashtag = (i) => (e) => {
        let _hashtags = [...props.hashtags];
        _hashtags.splice(i, 1);
        props.setHashtags(_hashtags);
    }

    if (!props.hashtags){
        return;
    }

    return (
        <div>

            <Box>

                <Chip color="primary" icon={<TagIcon />} label="해시태그" />

                {
                    props.hashtags.length < MAX_HASHTAG
                        ? <IconButton sx={{ ml: 3 }} onClick={addHashtag}> <ControlPointIcon color="primary"/> </IconButton>
                        : <Typography sx={{ ml: 3 }} variant="span" color="text.secondary">해시태그는 최대 {MAX_HASHTAG}개까지 작성 가능합니다</Typography>
                }

            </Box>

            {
                props.hashtags.map((v, i) => {
                    return (
                        <TextField
                            key={i}
                            sx={{ m: 1 }}
                            value={v}
                            onChange={handleHashtag(i)}
                            InputProps={{
                                startAdornment: <InputAdornment position="start">
                                    <TagIcon color="primary" />
                                </InputAdornment>,
                                endAdornment: <InputAdornment position="start">
                                    <IconButton onClick={deleteHashtag(i)}>
                                        <RemoveCircleOutlineIcon color="primary" />
                                    </IconButton>
                                </InputAdornment>
                            }}
                        />
                    )
                })
            }

        </div>
    )
}