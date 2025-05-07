import axios from "axios";
import { useEffect, useState } from "react";
import API_KEY from "./API_KEY";
import { CardMedia } from "@mui/material";
import CircularIndeterminate from "./CircularIndeterminate";


// const getSecureBaseUrl = async ()=>{
//     const url = "https://api.themoviedb.org/3/configuration?api_key="+API_KEY
//     axios.get(url).then((gotData)=>{
//         if (gotData.status===200){
//             console.log(gotData.data.images.secure_base_url)
//             return gotData.data.images.secure_base_url
//         } 
//     }).catch((err)=>{
//         console.log(err)
//     })
// }

const GetImgSrc = async (movie_id)=>{    
    const secureUrl = "https://image.tmdb.org/t/p/"
    const backUrl = `https://api.themoviedb.org/3/movie/${(movie_id)}/images?api_key=${API_KEY}`
    if (movie_id){
        try{
            return await axios.get(backUrl).then((res)=>{
                return secureUrl + "original" + res.data.backdrops[0].file_path    
            })
        } catch(err){
            console.log(err)
        }
    } 
}   

function GetImage(props){

    let [imgSrc, setImgSrc] = useState("")
    let [loaded, setLoaded] = useState(false)

    GetImgSrc(props.movie_id).then((res)=>{
        if (res){
            setLoaded(true)
            setImgSrc(res)
        } else {
            setLoaded(false)
        }
    })
    
    return(
        <>
        {
            loaded 
            ? <>
                <CardMedia
                    component="img"
                    height="100%"
                    image={imgSrc}
                    
                    alt={props.imgTitle?`${props.imgTitle}.jpg`:"img.jpg"}
                    />
            </>
            : <CircularIndeterminate/>
        }
        </>
    )
}

export default GetImage