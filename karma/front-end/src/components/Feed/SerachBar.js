import { useState } from 'react';
import Form from 'react-bootstrap/Form';
import InputGroup from 'react-bootstrap/InputGroup';
import { Button } from 'react-bootstrap';

const SearchBar = () => {

    const [option, setOption] = useState(0);
    const searchOptions = ['제목', '글쓴이']


    return (
      <InputGroup className="mb-3">
        {
            searchOptions.map((s, i)=>{
                return (
                    <Button key={i} 
                    onClick={(e)=>{setOption(i)}}
                    variant={option === i ? "primary" : "outline-secondary"}>{s}</Button>
                )
            })
        }
        <Form.Control placeholder='검색어를 입력하세요'/>
        <Button variant='success'>검색</Button>
      </InputGroup>
    );
}

export default SearchBar;