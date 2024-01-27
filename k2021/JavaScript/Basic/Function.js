// 함수 선언식
function 인사(인사말){
    console.log(인사말);
}

// 함수표현식
const 인사2 = function(인사말){
    console.log(인사말);
}

// Arrow 함수
const 인사3 = (인사말) => console.log(인사말);

인사('하이');
인사2('헬로');
인사3('바이');
