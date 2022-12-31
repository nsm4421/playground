import { useEffect } from "react";
import logout from "../../../utils/logout";
import RegisterForm from "./registerForm";

const Index = ({username}) => {
    useEffect(()=>{
        if (username!==""){
            logout();
        }
    }, [])
    return (
        <div>            
            <RegisterForm/>
        </div>
    )
}

export default Index;