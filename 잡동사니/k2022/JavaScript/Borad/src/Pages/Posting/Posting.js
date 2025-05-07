import { useState, useEffect } from "react";
import app from "../../api/App";
import HandleDB from "../../api/HandleDB";
import Posting from "../../components/Posting/Posting";
import { getDatabase } from "firebase/database";
import { get } from "firebase/database";
import { ref } from "firebase/database";
import { child } from "firebase/database";

const PostingPage = ()=>{

    const [postings, setPostings] = useState({});

    useEffect(()=>{
        const database = getDatabase(app)        
        const dbRef = ref(database);
        get(child(dbRef,  '/posting'))
        .then((snapshot)=>{
            const data = snapshot.val()
            if (data){
                setPostings(data);
            }
        })
        .catch((e)=>{
            alert("Error : ", e)
        })
    }, [])

    return (
        <div>

            {
                postings
                ?
                Object.keys(postings).map((k, i)=>{
                    const posting = postings[k]
                    const newPosting = {...posting}
                    const newImgData = newPosting.imgData.filter((data)=>{return data!=""})
                    newPosting.imgData = newImgData;
                    return <Posting posting={newPosting} pid = {k} key={i}/>
                })
                :null
            }
          
        </div>
    )

}


export default PostingPage;