const http = require('http');
const url = require('url');

http.createServer((request, response) => {

    const get = url.parse(request.url, true).query;

    if (request.method === "GET"){
        response.writeHead(200, {'Content-Type' : 'text/html'});
        response.end(`<h1> REQUEST : ${JSON.stringify(get)}</h1>`);

    }
    console.log(`${request.method} 요청 발생`);
}).listen(5000, ()=>{
    console.log("서버 실행 중");
})

