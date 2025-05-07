import React, { useState, useEffect } from 'react';
import CircularIndeterminate from './utils/CircularIndeterminate'
import TrendingTable from './utils/TrendingTable';
import API_KEY from './utils/API_KEY';

const axios = require('axios');


// IMDB api key
// const API_KEY = "6c5223e34ed7c823fbb20f048a65cd81"

// 인기 영화 list 20개 
const getTrending = async ()=>{
    const url = "https://api.themoviedb.org/3/trending/movie/day?api_key="+API_KEY
    try{
        return await axios.get(url)
        .then((res)=>{
            if (res){
                if (res.status === 200){
                    return res.data.results
                }
            }
        })
    } catch (err){
        console.error(err)
    }
}


export default function Trending(){
   
    let [items, setItems] = useState([])
    let [loaded, setLoaded] = useState(false)

    useEffect(()=>{
        getTrending().then((dataGot)=>{
            if (dataGot){
                setItems(dataGot)
                console.log(items)
            }
        })
    }, [])

    useEffect(()=>{
        if (items.length === 0){
            setLoaded(false)
        } else {
            setLoaded(true)
        }
    }, [items.length])

    return (
        <>
            {
                loaded
                ? <TrendingTable items={items}/>
                : <CircularIndeterminate/>
            }
        </>
    )

}


            

