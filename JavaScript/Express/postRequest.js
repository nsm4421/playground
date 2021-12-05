// express 모듈 불러오기
const express = require('express')

// fs 모듈 불러오기
const fs = require('fs')

// body parser
const bodyParser = require('body-parser')

const app = express()
app.use(bodyParser.urlencoded({extended:true}))

// 서버 포트번호
const portNum = 3003

// login 주소로 접근시
app.get('/login', (request, response) => {    
    fs.readFile('./login.html', (error, data)=>{
        // login.html 불러오는데 실패하면
        if (error) {
            console.log("html 불러오는 도중 Err")
        // login.html 불러오는데 성공
        } else {
            // Header 달아주기
            response.writeHead(200, {'Content-Type' : 'text/html'})
            // html 보여주기
            response.end(data)
        }
    })
})

app.post('/login', (request, response) => {
    // POST 요청의 body를 읽어서 Json으로 바꿈
    const loginForm = request.body
    response.send(`아이디는 ~ ${loginForm.id} 비번은 ${loginForm.pw}`)
})

// 서버 실행
app.listen(portNum, ()=>{
    console.log(`Server is running on port ${portNum}`)
})