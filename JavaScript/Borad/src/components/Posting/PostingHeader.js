import './Posting.css'
import MoreHorizIcon from '@mui/icons-material/MoreHoriz';
import { Tooltip } from '@mui/material';

// 머릿글
const PostingHeader = ({imgSrc,nickName})=>{
    return (
        <div className='posting__header'>
            <div className='posting__header__box'>
                {/* 프사 아바타 */}
                <img src={imgSrc}/>
                {/* 아이디 */}
                <span className='posting__header__name'>{nickName}</span>
            </div>
            {/* 더보기 버튼 */}
            <Tooltip title="더보기">
                <MoreHorizIcon className='posting__header__button'/>
            </Tooltip>

        </div>        
    )
}

export default PostingHeader;
