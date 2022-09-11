import { useEffect, useState } from 'react';
import Tab from 'react-bootstrap/Tab';
import Tabs from 'react-bootstrap/Tabs';
import GoogleRegister from './GoogleRegister';
import NaverRegister from './NaverRegister';
import RegisterWithUsernameAndPassoword from './RegisterWithUsernameAndPassoword';

const Register = () => {
    const providers = [
        "Email & Password", 
        "Google",
        "Naver"
    ]
    const [selected, setSelected] = useState(0);
    const registerForms = [
        <RegisterWithUsernameAndPassoword/>,
        <GoogleRegister/>,
        <NaverRegister/>
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
            {registerForms[selected]}
        </div>
    );
}


export default Register; 