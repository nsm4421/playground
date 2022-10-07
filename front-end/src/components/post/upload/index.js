import { useState } from 'react';
import Tab from 'react-bootstrap/Tab';
import Tabs from 'react-bootstrap/Tabs';
import { GrCheckboxSelected } from '@react-icons/all-files/gr/GrCheckboxSelected';
import { Container } from 'react-bootstrap';
import Feed from './feed/index';
import Music from './music/index';

const Index = () => {
  
    const labels = ["피드", "음악"];
    const tabs = [<Feed/>, <Music/>];
    const [selected, setSelected] = useState(labels[0]);

    const Header = ({idx}) => {
        const text = labels[idx];
        if (text === selected){
            return (
                <span><GrCheckboxSelected className="mr-3"/>{text}</span>    
            )
        } 
        return <span>{text}</span>
    }

    return (
        <Container>
            <Tabs defaultActiveKey="포스팅" activeKey={selected} onSelect={s=>setSelected(s)} className="mb-3 mt-3">
                        
                        {
                            labels.map((t, i) =>{
                                return (
                                    <Tab key={i} eventKey={t} title={<Header idx={i}/>} >
                                        {tabs[i]}
                                    </Tab>
                                )
                            })
                        }
                    </Tabs>
        </Container>
);
}

export default Index;