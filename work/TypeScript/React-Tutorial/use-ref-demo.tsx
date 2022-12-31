import { useEffect, useRef } from "react"

export const UseRefDemo = ()=>{
    const initValue = null
    const inputTagRef = useRef<HTMLInputElement>(initValue)

    useEffect(()=>{
        inputTagRef.current?.focus()
    }, [])

    return (
        <div>
            <input/><br/>
            <input ref={inputTagRef} placeholder='focus on'/><br/>
            <input/>            
        </div>
    )
}