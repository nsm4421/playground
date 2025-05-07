const http = require('http');
const url = require('url');
const fs = require('fs');

http.createServer((request, response) => {

    const get = url.parse(request.url, true).query;

    if (request.method === "GET"){
        fs.readFile('./login.html', (error, data) => {
            if (error) throw  error
            response.writeHead(200, {'Content-Type' : 'text/html'});
            response.end(data);
            console.log(`${request.method} 요청 발생`);
        })
    } else if (request.method == "POST"){
        request.on('data', (data)=>{
            response.writeHead(200, {'Content-Type' : 'text/html'});
            response.end(data);
            console.log(`${request.method} 요청 발생`);
        })
    }
}).listen(5000, ()=>{
    console.log("서버 실행 중");
})

