import { useEffect } from "react";
import logout from "../../../utils/logout";
import LoginForm from "./loginForm";

const Index = ({username}) => {
    useEffect(()=>{
        if (username!==""){
            logout();
        }
    }, [])    
    return (
        <div>

            <LoginForm/>
         
        </div>
    )
}

export default Index;