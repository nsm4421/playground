import {InputGroup, FormControl, Button} from 'react-bootstrap'

function SearchBar(){
    return (
        <>
        <InputGroup size="sm">
            <FormControl aria-label="Small" aria-describedby="inputGroup-sizing-sm" />
        </InputGroup>
            <Button variant="primary">검색</Button>
        </>
    )
}

export default SearchBar;