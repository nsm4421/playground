// 모듈 import
const fs = require('fs');
const http = require('http');
const url = require('url');

// 서버 생성
http.createServer((request, response) => {
    let pathname = url.parse(request.url).pathname;
    if (pathname==='/html'){
        fs.readFile('sampleHtml.html', (error, data)=>{
            if (error) throw  error
            response.writeHead(200, {'Content-Type' : 'text/html'});
            response.end(data);
            console.log(`URL : ${url.parse(request.url)}`);
        })
    } else if (pathname === '/image'){
        fs.readFile('sampleImage.jpg', (error, data)=>{
            if (error) throw  error
            response.writeHead(200, {'Content-Type' : 'image/jpg'});
            response.end(data);
            console.log(`URL : ${url.parse(request.url)}`);
        })
    }
}).listen(5000, ()=>{
    console.log("서버 실행중");
})