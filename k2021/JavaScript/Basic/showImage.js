const fs = require('fs');
const http = require('http');

// 서버 생성
http.createServer((request, response) => {
    // JPG 이미지 파일 읽기
    fs.readFile('./sampleImage.jpg', (error, data) => {
        if (error) throw error
        // 응답 Header 작성
        response.writeHead(200, {'ContentType' : 'image/jpg'});
        // 응답본문 -> HTML 파일
        response.end(data);
    })
}).listen(5000, ()=>{
    console.log('서버 동작중');
});