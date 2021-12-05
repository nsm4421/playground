// express 모듈 불러오기
const express = require('express')

const app = express()

// 서버 포트번호
const portNum = 3001

// 특정 url로 접근시
app.get('/', (request, response, next) => {    
    response.send("Hello World")
})

// 서버 실행
app.listen(portNum, ()=>{
    console.log(`Server is running on port ${portNum}`)
})
