import { useCallback, useEffect, useState, Fragment } from 'react';
import { useInView } from "react-intersection-observer"
import FeedSinglePage from './FeedSinglePage';
import SearchBar from './SerachBar';
import Spinning from './Spinning';
import axios from 'axios';

const test_page = [
    {
        title:"제목1",
        author:"글쓴이1",
        body:"본문1",
        writeAt:"2022-09-01",
    },
    {
        title:"제목2",
        author:"글쓴이2",
        body:"본문2",
        writeAt:"2022-09-01",
    },
    {
        title:"제목3",
        author:"글쓴이3",
        body:"본문3",
        writeAt:"2022-09-01",
    },
    {
        title:"제목4",
        author:"글쓴이4",
        body:"본문4",
        writeAt:"2022-09-01",
    },
]

const test_data = [
    [
        {
            title:"제목1",
            author:"글쓴이1",
            body:"본문1",
            writeAt:"2022-09-01",
        },
        {
            title:"제목2",
            author:"글쓴이2",
            body:"본문2",
            writeAt:"2022-09-01",
        },
        {
            title:"제목3",
            author:"글쓴이3",
            body:"본문3",
            writeAt:"2022-09-01",
        },
        {
            title:"제목4",
            author:"글쓴이4",
            body:"본문4",
            writeAt:"2022-09-01",
        },
    ],
    [
        {
            title:"제목1",
            author:"글쓴이1",
            body:"본문1",
            writeAt:"2022-09-01",
        },
        {
            title:"제목2",
            author:"글쓴이2",
            body:"본문2",
            writeAt:"2022-09-01",
        },
        {
            title:"제목3",
            author:"글쓴이3",
            body:"본문3",
            writeAt:"2022-09-01",
        },
        {
            title:"제목4",
            author:"글쓴이4",
            body:"본문4",
            writeAt:"2022-09-01",
        },
    ],
    [
        {
            title:"제목1",
            author:"글쓴이1",
            body:"본문1",
            writeAt:"2022-09-01",
        },
        {
            title:"제목2",
            author:"글쓴이2",
            body:"본문2",
            writeAt:"2022-09-01",
        },
        {
            title:"제목3",
            author:"글쓴이3",
            body:"본문3",
            writeAt:"2022-09-01",
        },
        {
            title:"제목4",
            author:"글쓴이4",
            body:"본문4",
            writeAt:"2022-09-01",
        },
    ],
]


const FeedPage = () => {

    const baseApiUrl = "/api/v1/feed/get";
    const [feeds, setFeeds] = useState(test_data);
    const [totalPage, setTotalPage] = useState(1);
    const [isFetching, setIsFetching] = useState(false);
    const [ref, inView] = useInView();
  
    const fetchFeed = useCallback(async () => {
        setIsFetching(true);
        setFeeds([...feeds, test_page]);
        const requestUrl = `${baseApiUrl}/${totalPage+1}`;
        await axios.get(requestUrl)
        .then((res)=>{
            setFeeds([...feeds, res]);
        })
        .catch((e)=>{
            console.log(e);
        })
        .finally(()=>{
            setIsFetching(false);
        })
    }, [totalPage]);

    useEffect(() => {
        fetchFeed()
      }, [fetchFeed]);
  
    useEffect(() => {
      if (inView && !isFetching) {
        setTotalPage(currentPage => currentPage + 1)
      }
    }, [inView, isFetching])
  
    return (
      <div>
        {
            isFetching
            ?<Spinning/>
            :<div>
                {
                    feeds.map((f, i) => (
                        <Fragment key={i}>
                            {
                                feeds.length - 1 == i 
                                ?<div ref={ref}><FeedSinglePage data={f}/></div>
                                :<div><FeedSinglePage data={f}/></div>
                            }
                        </Fragment>
                    ))
                }
            </div>
        }
        
        </div>
    )
}

export default FeedPage;