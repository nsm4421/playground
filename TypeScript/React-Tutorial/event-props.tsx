import React from "react"

type EventProps = {
    handleClick : (e:React.MouseEvent<HTMLButtonElement>) => void,
    handleChange : (e:React.ChangeEvent<HTMLInputElement>) => void,
}

export const EventDemoCompoent = (props:EventProps)=>{
    return(
        <div>
            <h1>Event</h1>
            <h3>onClick</h3>
            <button onClick={props.handleClick}>Click me</button>

            <h3>onChange</h3>
            <input onChange={props.handleChange}/>

        </div>
    )
}