import { Spinner } from "react-bootstrap";

const Spinning = () => {
    return (
        <Spinner animation="border" role="status">
            <span className="visually-hidden">Loading...</span>
        </Spinner>
    )
};

export default Spinning;