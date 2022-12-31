import { useState } from "react"
import Button from "../utils/Button";
import { getAuth, createUserWithEmailAndPassword, updateProfile } from "firebase/auth";
import InputBox from "../utils/InputBox"
import TextArea from "../utils/TextArea";
import HandleWritting from '../../api/HandleWritting';
import './Writting.css';
import app from "../../api/App";
import ImagesAdd from "./ImageUpload";
import { useHistory } from "react-router-dom";

const Writting = ()=>{

    const history = useHistory();
    const [userInput, setUserInput] = useState({title:"", article:"", imgData:Array(5).fill("")});

    const handleOnClick = ()=>{

        if (!userInput.title){
            alert('Title is not given');
            return;
        }

        if (!userInput.article){
            alert('Article is not given');
            return;
        }

        const auth = getAuth(app);
        if (auth.currentUser){
            HandleWritting(auth.currentUser.uid, userInput).then((res)=>{
                if (res.status){
                    history.push('/')
                } else {
                    alert(res.error)
                }
            })
            return
        } else {
            alert('Not Logined');
            return
        }
    }

    return (
        <div>
            <InputBox className='writting__title' label={'Title'} objKey={'title'} 
                    helperText={'Write Title Of Article'}
                    userInput = {userInput} handleUserInput = {setUserInput} inputType = {'text'}/>            
            <div className="margin__block"></div>
            <TextArea maxLen={1000} objKey={'article'} userInput={userInput} setUserInput={setUserInput}/>
            <div className="writting__button__box">
                <ImagesAdd userInput = {userInput} setUserInput={setUserInput}/>
                <Button className='writting__submit__btn' label={'Submit'} onClick={handleOnClick}/>
            </div>
        </div>
    )
}

export default Writting