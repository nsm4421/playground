import { useEffect, useRef, useState } from "react"

export const UseRefDemo_Timer = ()=>{
    
    const [timer, setTimer] = useState(0)
    const intervalRef = useRef<number|null>(null)

    const stop = ()=>{
        if (intervalRef.current){
            window.clearInterval(intervalRef.current)
        }
    }

    useEffect(()=>{
        intervalRef.current = window.setInterval(()=>{
            setTimer((timer)=>timer+1)
        }, 1000)
        return ()=>stop()
    }, [])

    return (
        <div>
            Elapsed : {timer}
            <br/>
            <button onClick={()=>stop()}>stop</button>
        </div>
    )
}