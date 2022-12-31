import { useEffect, useState } from "react";
import { Typography } from "@mui/material"
import { Fab } from "@mui/material";
import { TextField } from "@mui/material";
import SaveIcon from '@mui/icons-material/Save';
import { Tooltip } from "@mui/material";
import CalendarMonthIcon from '@mui/icons-material/CalendarMonth';
import { Modal } from "@mui/material";
import { Box } from "@mui/system";
import ClearIcon from '@mui/icons-material/Clear';
import InsertPhotoIcon from '@mui/icons-material/InsertPhoto';
import WriteDiary from "../api/WriteDiary";

// 사용자 입력 (제목, 일기)
const UserInput = ({title, multiline, maxRows, maxLetter, input, setInput})=>{

    return (
        <div style={{display : 'flex', justifyContent:'center', margin:'10px', alignItems:'center'}}>
            <Typography sx={{margin:'30px'}} variant="h6">{title}</Typography>
            <TextField
                multiline={multiline}
                maxRows={maxRows}
                value={input}
                variant="filled"
                label={input === ""?"":`${input.length}/${maxLetter}`}
                onChange={(e)=>{
                    let input_ = e.target.value;
                    if (input_.length>=maxLetter){
                        input_ = input_.slice(0, maxLetter)
                    };
                    setInput(input_);
                }}
                sx={{ width: "80%", bgcolor:'white',}}
                />
        </div>
    )
}

// 모달창(날짜 선택)
const PickCalendarModal = ({showModal, setShowModal, setToday})=>{

    return (
        <Modal
            open={showModal}
            onClose={()=>{setShowModal(false)}}>
            <Box 
                sx={{position: 'absolute', top:"30%", justifyContent:'center', alignContent:'center', 
                width:'100%', bgcolor:'#fff', display:'center', padding:'20px'}}>

                <Typography variant="h6" component="h2" sx={{color:'black', marginRight:'30px'}}>
                    날짜를 선택하세요
                </Typography>

                <input type="date" 
                    onChange={(e)=>{
                        const clicked = e.target.value;
                        if (clicked!==""){
                            setToday(clicked)         
                        };
                    }}
                ></input>    

                <ClearIcon sx={{color:'black', marginLeft:'30px'}} onClick={()=>{setShowModal(false)}}/>
            
            </Box>
        </Modal>
    )
}

// 날짜 선택
const PickCalendar = ({setToday})=>{
    const [showModal, setShowModal] = useState(false);
    
    return (
        <div> 
            <Tooltip title="날짜변경하기" placement="top">
                <Fab color="secondary" aria-label="edit"
                    sx = {{position:'absolute', bottom:'80px', right:'100px'}}
                    onClick={()=>{setShowModal(true)}}>
                    <CalendarMonthIcon/>
                </Fab>
            </Tooltip>

            {/* 날짜 선택 모달창 */}
            {
                showModal
                ?<PickCalendarModal showModal={showModal} setShowModal={setShowModal} setToday={setToday}/>
                :null
            }
        </div>
    )
}

// 사진 추가 버튼
const AddPictureButton = ({_id})=>{
    return (
        <div> 
            <Tooltip title="사진추가하기" placement="top">
                <Fab color="secondary" aria-label="edit"
                    sx = {{position:'absolute', bottom:'80px', right:'190px'}}
                    onClick={()=>{document.getElementById(_id).click()}}>
                    <InsertPhotoIcon/>
                </Fab>
            </Tooltip>
        </div>
    )
}

// 사진 추가 파일다이얼로그
const HiddenInput = ({_id, imgSrc,  setImgSrc})=>{
    return (
        <input id={_id} type="file" style={{'display':'none'}} 
            accept=".gif, .jpg, .png"
            onChange={(e)=>{
                const seleted = e.target.files[0]
                if (seleted){
                    const reader = new FileReader();
                    reader.onload = (e_)=>{
                        setImgSrc(e_.target.result)
                    }
                    reader.readAsDataURL(seleted)
                }
        }}></input>
    )
};

// 저장 버튼
const SubmitButton = ({payload, setTab, diaryList, setDiaryList})=>{
    
    const handleSubmit = ()=>{
        const td = new Date();
        const _id = td.getTime();
        WriteDiary({_id: _id,payload:payload});
        const newDiaryList = {...diaryList};
        newDiaryList[_id] = payload;
        setDiaryList(newDiaryList)
        setTab(0)
        alert('일기가 업로드 되었습니다.')
    }     

    return (
        <div onClick={handleSubmit}> 
            <Tooltip title="저장하기" placement="top">
                <Fab color="secondary" aria-label="edit"
                    sx = {{position:'absolute', bottom:'80px', right:'10px'}}>
                    <SaveIcon/>
                </Fab>
            </Tooltip>
        </div>
    )
}

// 일기장 전첸 화면
const Diary = ({diaryList, setDiaryList, setTab})=>{

    const [title, setTitle] = useState("");
    const [article, setArticle] = useState("");
    const [today, setToday] = useState("");
    const [imgSrc, setImgSrc] = useState("");
    const [payload, setPayload] = useState({});
    
    useEffect(()=>{ // 제일 먼저 시작할 때 날짜는 today변수는 오늘 날짜로 세팅하기 
        const td = new Date();
        setToday(`${td.getFullYear()}-${td.getMonth()+1}-${td.getDay()+1}`)
    }, [])
    
    useEffect(()=>{ // 사용자 입력이 바뀔 때 마다 payload 변수 업데이트
        setPayload({
            title:title,
            article:article,
            writeAt:today,
            imgSrc:imgSrc
        })
    },[title, article, today, imgSrc])

    return (
        <div> 

            <h1 style={{margin:'20px'}}>Diary ({today})</h1>
          
            <UserInput title={'제목'} multiline={false} maxRows={1} maxLetter={50} input={title} setInput={setTitle}/>
            <UserInput title={'일기'} multiline={true} maxRows={20} maxLetter={2000} input={article} setInput={setArticle}/>

            <AddPictureButton _id={'_hidden'}/>
            <PickCalendar setToday={setToday}/>
            <HiddenInput _id={'_hidden'} imgSrc={imgSrc} setImgSrc={setImgSrc}/>
            <SubmitButton payload={payload} setTab={setTab} diaryList={diaryList} setDiaryList={setDiaryList}/>

            {/* 썸네일 */}
            {
                imgSrc
                ?
                <div style={{display : 'flex', justifyContent:'center', margin:'10px', alignItems:'center'}}>
                <Typography sx={{margin:'30px', display:'inline-block'}} variant="h6">썸네일</Typography>
                <img src={imgSrc}></img>
                </div>
                : null
            }
           
        </div>
    )
}

export default Diary;