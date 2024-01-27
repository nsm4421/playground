// express 모듈 불러오기
const express = require('express')

const app = express()

// 서버 포트번호
const portNum = 3002

// url parameter
app.get('/team', (request, response) => {    
    let team = parseInt(request.query.team)      // 조
    let sex = request.query.sex     // 성별
    let name = request.query.name       // 이름

    if (1<=team & team<5){
        response.send(`${team}조 / 성별 ${sex} / 이름 ${name} 입니다.`)
    } 
})

// 서버 실행
app.listen(portNum, ()=>{
    console.log(`Server is running on port ${portNum}`)
})