const fs = require('fs');
const http = require('http');

// 서버 생성
http.createServer((request, response) => {
    // HTML 파일 읽기
    fs.readFile('./sampleHtml.html', (error, data) => {
        if (error) throw error
        // 응답 Header 작성
        response.writeHead(200, {'ContentType' : 'text/html'});
        // 응답본문 -> HTML 파일
        response.end(data);
    })
}).listen(5000, ()=>{
    console.log('서버 동작중');
});