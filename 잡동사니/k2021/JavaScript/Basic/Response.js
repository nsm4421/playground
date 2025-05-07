const http = require('http');

http.createServer((request, response) => {
    // 응답 헤더 작성
    response.writeHead(200, {'Content-Type' : 'text/html'});
    // 응답 본문 작성
    response.end('<h1>하이루~</h1>');
}).listen(5000, ()=>{
    console.log("서버 동작중")
})