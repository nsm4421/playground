import axios from "axios";
import Api from '../../Api'

/**
 * 유효성 판단
 * @param {String} type - username, email, password 
 * @param {*} data 
 * @returns {Boolean} 유효성 여부
 */
const Validate = (type, data) => {
    switch (type){
        case "username":
            return isValidUsername(data);
        case "email":
            return isValidEmail(data);
        case "passoword":
            return isValidPassword(data);
    }
}

const isValidUsername = async(username) => {
    if (username === ""){
        return false;
    }
    const len = String.length(username);
    if (len<2 || len>15){
        return false;
    }

    await axios.post(Api.checkIsDuplicated.URL, {
        type:"username",
        username
    }).then((res)=>{
        return true;
    }).catch((err)=>{
        console.log(err);
        return false;
    })

    return true;
}

const isValidEmail = async(email) => {
    if (email === ""){
        return false;
    }
    const len = String.length(email);
    if (len<2 || len>15){
        return false;
    }

    await axios.post(Api.checkIsDuplicated.URL, {
        type:"email",
        email
    }).then((res)=>{
        return true;
    }).catch((err)=>{
        console.log(err);
        return false;
    })

    return true;
}

const isValidPassword = async({password, passwordConfirm}) => {
    if (password!==passwordConfirm){
        return false;
    }
    if (String.length(password)>=8){
        return false;
    }
    return true;
}


export default Validate;