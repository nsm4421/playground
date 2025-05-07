// 입력 : 장르 id가 담긴 list
// 출력 : 장르 string

export default function WhatIsGenre(genre_id_list){
    // https://api.themoviedb.org/3/genre/movie/list?api_key=<<api_key>>&language=en-US
    const genre_mapping = [{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}]
    let genres = []
    genre_id_list.forEach((gen_id)=>{
        genre_mapping.forEach((item)=>{
            if(gen_id === item.id){
                genres.push(item.name)
            }
        })
    })
    return genres
  }