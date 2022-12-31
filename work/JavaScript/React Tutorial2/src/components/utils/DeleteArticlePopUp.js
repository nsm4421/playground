
import { useState } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import ArrowForwardIcon from '@mui/icons-material/ArrowForward';
import Button from '@mui/material/Button';
import PasswordInput from './PasswordInput';
import DeleteArticle from '../API/DeleteArticle';

const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 400,
  bgcolor: 'background.paper',
  border: '2px solid #000',
  boxShadow: 24,
  p: 4,
};

export default function DeleteArticlePopUp(props) {

    let [password, setPassword] = useState("");

    return (
    <div>
        <Modal
            open={props.openDeleteModal}
            onClose={()=>{props.setOpenDeleteModal(false);}}
            aria-labelledby="modal-modal-title"
            aria-describedby="modal-modal-description">

        <Box sx={style}>

            <Typography id="modal-modal-title" variant="h6" component="h2">
            {props.title}
            </Typography>

            <Typography id="modal-modal-description" sx={{ mt: 2 }}>
                해당 게시글을 삭제하시겠습니까?
            </Typography>

            <PasswordInput password={password} setPassword={setPassword}/>
            
            {/* 삭제버튼 */}
            <Button onClick={()=>{DeleteArticle(props._id, password)
           }}>
                <ArrowForwardIcon/>Delete
            </Button>


            </Box>

        </Modal>
    </div>
    );
}
