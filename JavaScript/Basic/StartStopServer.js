// http 모듈 import
const http = require('http');

// 서버 생성
const server = http.createServer();
// 포트번호
const portNum = 5000;


// 서버 실행
server.listen(portNum,
    ()=>{
        now = new Date();
        console.log(now.toLocaleTimeString());
        console.log(`서버 작동중 / 포트번호 : ${portNum}`)
    });

// 웹서버 종료 함수
const closeServer = ()=>{
    server.close();
    now = new Date();
    console.log(now.toLocaleTimeString());
    console.log(`서버 종료 / 포트번호 : ${portNum}`);
};

// 3초 뒤 서버 종료
setTimeout(closeServer, 3000);