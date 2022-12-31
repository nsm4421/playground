import './utils.css'
import { Tooltip } from '@mui/material';

// 사용자 입력
const InputBox = ({label, objKey, helperText, userInput, handleUserInput, inputType})=>{

    // 사용자 입력에 따라 state(userInput)을 변경하는 함수
    const handleChange = (e)=>{
        handleUserInput({...userInput, [objKey]:e.target.value});
    };

    return (
        <form className='register__inner__box'>
            <p className='register__inner__label'>{label}</p>
            <div className='register__inner__stick'/>
            <Tooltip title={helperText}>
                <input type={inputType?inputType:'text'} className='register__inner__input' autoComplete="on"
                    onChange={handleChange} value={userInput[objKey]}></input>
            </Tooltip>
        </form>        
    )
}

export default InputBox