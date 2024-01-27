const fs = require('fs');

// 동기(sync)적으로 텍스트 읽기
const data = fs.readFileSync('msg.txt');
console.log("동기");
console.log(data.toString());

// 비동기로 텍스트 읽기
fs.readFile('msg.txt', (err, data) => {
    if (err) throw err;
    console.log("비동기")
    console.log(data.toString());
});


