import React from 'react';
import { connect, useDispatch, useSelector } from 'react-redux';

function Movie(props){

    let state = useSelector((state)=>state.reducer);
    let state2 = useSelector((state)=>state.reducer2);
    let dispatch = useDispatch();

     return (
        <>
        <hr></hr>

        <p>영화제목 : {state[props.id].movie}</p>
        <p> 점수 : {state[props.id].star}</p>
        <button onClick={()=>{
            dispatch({ type : '+', id : props.id });
            dispatch({ type : 'changed', id : props.id})
            }}>+</button>
        <button onClick={()=>{
            dispatch({ type : '-', id : props.id })
            dispatch({ type : 'changed', id : props.id})
            }}>-</button>

        {
            state2[props.id]
            ? <p>점수가 변경됨</p>
            : null
        }

        </>
    )
}

// function stateToProps(state){
//     return {
//         state : state.reducer,
//         state2 : state.reducer2
//     }
// }

// export default connect(stateToProps)(Movie)

export default Movie;