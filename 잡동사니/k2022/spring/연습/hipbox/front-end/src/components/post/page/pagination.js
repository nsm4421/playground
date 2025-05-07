import { useState } from "react";

const Pagination = ({pageNum, setPageNum, totalPageNum}) =>{

    const [input, setInput] = useState(pageNum);

    const handleInput = (e) => {
        let p = e.target.value;
        p = Math.min(p, totalPageNum-1);
        p = Math.max(p, 0);
        setInput(p);
    }

    const handleClick = () =>{
        setPageNum(input);
    }

    return (
        <div>
            <input type="number" onChange={handleInput} value={input}></input>
            <button onClick={handleClick}>이동</button>
        </div>
    )
}

export default Pagination;