import './utils.css'

const TextArea = ({maxLen, objKey, userInput, setUserInput})=>{

    const handleChange = (e)=>{
        const uInput = e.target.value;
        setUserInput({... userInput, [objKey]:uInput.slice(0, maxLen)});
    };

    return (
        <div>            
            <textarea className="text__area" cols={100}
            rows={20} value={userInput[objKey]} onChange={handleChange}/>
            <p className='text__area__length'>{userInput[objKey]?userInput[objKey].length:0}/{maxLen}</p>
        </div>
    )
}

export default TextArea;