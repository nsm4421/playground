import React, { useEffect, useState } from "react"

type userInfo = {
    email:string,
    password:string
}

export const UseStateDemo = () => {

    const [user, setUser] = useState<userInfo>({} as userInfo)
    const [isVisible, setVisible] = useState<boolean>(false)
    const handleInput = (field:string) => (e :React.ChangeEvent<HTMLInputElement>)=>{
        setUser({...user, [field]:e.target.value})
    }
    const handleVisible = (e : React.MouseEvent<HTMLButtonElement>)=>{
        e.preventDefault()
        setVisible(!isVisible)
    }
    const showAlert = (e : React.MouseEvent<HTMLButtonElement>) => {
        e.preventDefault()
        const msg = `id : ${user.email} / password : ${user.password}`
        alert(msg)
    }

    return (
        <div>
            <h1>Use State Demo(Sign Up Form)</h1>

            <form>
                <div>
                    <label>email : </label>
                    <input type='email' onChange={handleInput('email')}/>
                </div>

                <div>
                    <label>password : </label>
                    <input type={isVisible?'text':'password'} onChange={handleInput('password')}/>
                    <button onClick={handleVisible}>visible?</button>
                </div>
            <button onClick={showAlert}>Show Alert</button>
            </form>

        </div>
    )

}