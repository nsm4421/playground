import Dialog from '@mui/material/Dialog';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Slide from '@mui/material/Slide';
import { forwardRef } from 'react';
import { DialogContent, Tooltip } from '@mui/material';
import UndoIcon from '@mui/icons-material/Undo';
import DetailPost from './DetailPost';

const Transition = forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

const IconBtn = ({title, Icon, onClick, label}) => {
  return (
    <Tooltip title={title}>
      <IconButton
          edge="start"
          color="inherit"
            onClick={onClick}
            aria-label="close">
          <Icon/>
          <Typography>{label}</Typography>
      </IconButton>
    </Tooltip>
  )
}

const FullScreenDialog = ({open, setOpen, post}) => {

  const handleClose = () => {
    setOpen(false);
  };

  return (
        <>
          <Dialog
            fullScreen
            open={open}
            onClose={handleClose}
            TransitionComponent={Transition}>
              <AppBar sx={{ position: 'relative' }}>
                  <Toolbar>
                    {/* 제목 */}
                    <Typography sx={{ ml: 2, flex: 1 }} variant="h6" component="div">
                        {post.title}
                    </Typography>

                    {/* 아이콘 */}
                    <IconBtn title="포스팅 페이지로 돌아가기" onClick={handleClose} Icon={UndoIcon} label="돌아가기"/>

                  </Toolbar>
              </AppBar>

              {/*  보여줄 내용 */}
              <DialogContent>
                  <DetailPost postId={post.id}/>
              </DialogContent>
          </Dialog>
        </>
  );
}

export default FullScreenDialog;