import { useEffect, useState } from "react";
import AddPhotoAlternateIcon from '@mui/icons-material/AddPhotoAlternate';
import './Writting.css'

const SingleImageAdd = ({idx, imgData, setImgData})=>{

    const reader = new FileReader();
    const _id = `img${idx}`

    reader.onload = () => {
        setImgData(reader.result);
    };

    reader.onerror = (error) => {
      alert(error);
    };

    return (
        <div className="add__image__inner__box">
            {
                imgData!==""
                
                ? 
                <div onClick={()=>{setImgData("")}}><img className="img__preview" src={imgData}></img></div>      
                
                : <div onClick={()=>{
                        const imgAdd = document.getElementById(_id)
                        imgAdd.click();
                    }} 
                    className='add__image__icon__box'
                    >
                    <AddPhotoAlternateIcon sx={{fontSize:'5vh'}}/>
                </div>
            }

            <input type="file" id={_id} name={_id} alt={_id} accept="image/png, image/jpeg" className="add__image" 
                onChange={(e)=>{
                    let file = document.querySelector(`#${_id}`).files[0];
                    reader.readAsDataURL(file);                    
            }}></input>

        </div>
    )
}


const ImagesAdd = ({userInput, setUserInput})=>{

    const getImgData = (idx) => {return userInput.imgData[idx]}
    const setImgData = (idx) => (newImgData) => {
        const newUserInput = {...userInput};
        newUserInput.imgData[idx] = newImgData;
        setUserInput(newUserInput);
    }

    return (
        <div className="add__image__box">
            {
                Array(5).fill(5).map((_, idx)=>{
                    return <SingleImageAdd idx={idx} key={idx} imgData={getImgData(idx)} setImgData={setImgData(idx)}/>
                })
            }
        </div>
    )
};

export default ImagesAdd;