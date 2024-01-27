import './Posting.css'
import WindowStore from '../../store/WindowStore';
import PostingHeader from './PostingHeader';
import PostingBody from './PostingBody';
import PostingFooter from './PostingFooter';

const Posting = ({posting,  pid}) => {

    return (
        <div>
        {
            posting
            ? 
                <div className='posting__container'>
                    
                    <PostingHeader imgSrc={`${process.env.PUBLIC_URL}/test.jpg`} nickName={posting.nickName?posting.nickName:posting.uid}/>
        
                    <PostingBody posting={posting}/>
                    
                    <PostingFooter posting={posting} pid={pid}/> 
                </div>
            : null
            }
        </div>
    )
}

export default Posting