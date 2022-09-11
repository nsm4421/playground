import { useEffect, useState } from 'react';
import Tab from 'react-bootstrap/Tab';
import Tabs from 'react-bootstrap/Tabs';
import NaverLogin from './NaverLogin';
import GoogleLogin from './GoogleLogin'
import LoginWithUsernameAndPassoword from './LoginWithUsernameAndPassoword'

const Login = () => {
    const providers = [
        "Email & Password", 
        "Google",
        "Naver"
    ]
    const [selected, setSelected] = useState(0);
    const LoginForms = [
        <LoginWithUsernameAndPassoword/>,
        <GoogleLogin/>,
        <NaverLogin/>
    ]

    return (
        <div>
            <Tabs
                defaultActiveKey={providers[selected]}
                onSelect={(k)=>{
                    providers.map((p, i)=>{
                        if (p === k){
                            setSelected(i);
                        }
                    })
                }} 
                activeKey={providers[selected]}
                className="mb-3">
                {
                    providers.map((p, i)=>{
                        return (
                            <Tab key={i} eventKey={p} title={p}/>    
                        )
                    })
                }
            </Tabs>
            {LoginForms[selected]}
        </div>
    );
}

export default Login;