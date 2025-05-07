import {Form} from 'react-bootstrap'


function LoadFile(props) {

    return (
        <>
        <Form.Group controlId="formFileLg" className="mb-3">
            <Form.Label>{props.label}</Form.Label>
            <Form.Control type="file" size="lg" />
        </Form.Group>
        </>
    )

    
}

export default LoadFile;