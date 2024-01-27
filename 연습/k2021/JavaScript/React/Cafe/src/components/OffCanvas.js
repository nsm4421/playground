import {Offcanvas, Button, InputGroup, FormControl} from 'react-bootstrap'
import {useState} from 'react'

function OffCanvasLeft({ name, ...props }) {
    let [show, setShow] = useState(false);  
    let handleClose = () => setShow(false);
    let handleShow = () => setShow(true);
    
    let [id, changeId] = useState("");
    let [pw, changePW] = useState("");
  
    return (
      <>
        <Button variant="primary" onClick={handleShow} className="me-2">
        {name}
        </Button>
        <Offcanvas show={show} onHide={handleClose} {...props}>
        <Offcanvas.Header closeButton>
        <Offcanvas.Title>로그인</Offcanvas.Title>
        </Offcanvas.Header>
        <Offcanvas.Body>   

            <InputGroup size="lg">
            <InputGroup.Text id="inputGroup-sizing-lg">id</InputGroup.Text>
            <FormControl aria-label="Large" aria-describedby="inputGroup-sizing-sm"
            onChange={(e)=>{changeId(e.target.value)}}/>
            </InputGroup>
            
            <InputGroup size="lg">
            <InputGroup.Text id="inputGroup-sizing-lg">pw</InputGroup.Text>
            <FormControl aria-label="Large" aria-describedby="inputGroup-sizing-sm"
            onChange={(e)=>{changePW(e.target.value)}}/>
            </InputGroup>

            <Button variant="success">로그인하기</Button>

        </Offcanvas.Body>
        </Offcanvas>
      </>
    );
}


export default OffCanvasLeft;