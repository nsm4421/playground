// replace
const 아침인사 = "굿모닝"
const 저녁인사 = 아침인사.replace('모닝', '이브닝');
console.log(`저녁인사 : ${저녁인사}`);

// split
const 단어 = 'A   B   C';
console.log(단어.split('  ')[0]);

// substring
const 단어2 = '12345678910'
console.log(`2~5번째 글자 : ${단어2.substring(2, 5)}`);