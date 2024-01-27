// http 모듈 import
const http = require('http');

// 서버 생성
const server = http.createServer();
// 포트번호
const portNum = 5000;

// request
server.on('request', () => {
    now = new Date();
    console.log(now.toLocaleTimeString());
    console.log('Client 측에서 요청 발생');
});

// connection
server.on('connection', () => {
    now = new Date();
    console.log(now.toLocaleTimeString());
    console.log('Client 측에서 접속 발생');
});

// close
server.on('colse', () => {
    now = new Date();
    console.log(now.toLocaleTimeString());
    console.log('서버 종료시 발생하는 이벤트');
});

// 서버 실행
server.listen(portNum, ()=>{
    now = new Date();
    console.log(now.toLocaleTimeString());
    console.log(`서버 동작 중 / 포트번호 : ${portNum}`);
});

// 웹서버 종료 함수
const closeServer = ()=>{
    server.close();
    now = new Date();
    console.log(now.toLocaleTimeString());
    console.log(`서버 종료 / 포트번호 : ${portNum}`);
};

// 15초 뒤 서버 종료
setTimeout(closeServer, 10000);