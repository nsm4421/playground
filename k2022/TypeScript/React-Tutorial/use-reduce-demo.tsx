import { useReducer } from "react";

type _state = {
    count:number
}

type _action = {
    type:'+'|'-',
}

const reducer = (state:_state, action:_action)=>{
    switch(action.type){
        case '+':
            return {count:state.count+1}
        case '-':
            return {count:Math.max(state.count-1, 0)}
        default:
            return state
    }
}

export const UseReducerDemo = ()=>{

    const [state, dispatch] = useReducer(reducer, {count : 0} as _state)
    const handleChange = (t:string) =>{dispatch({type:t} as _action)}

    return (
        <div>
            <h1>use reduce hook demo</h1>
            <div>
                <h3>Number of Shoes : {state.count}</h3>
                <button onClick={()=>handleChange('+')}>+</button>
                <button onClick={()=>handleChange('-')}>-</button>
            </div>            
        </div>
    )
}