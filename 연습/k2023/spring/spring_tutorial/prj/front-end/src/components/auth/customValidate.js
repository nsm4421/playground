const customValidate = (type, value) => {
    if (value === ""){
        return false;
    }
    let regex = "";
    switch(type){
        case "email":
            regex = /([\w-.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        case "password":
            regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
        case "username":
            regex = /^[가-힣a-zA-Z0-9]+$/
        case "nickname":
            regex = /^[가-힣a-zA-Z0-9]+$/
    }
    return regex.test(value);
}  

export default customValidate;