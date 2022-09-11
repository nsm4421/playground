import Button from 'react-bootstrap/Button';
import { Container } from 'react-bootstrap';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Card from 'react-bootstrap/Card';
import styled from 'styled-components';

const Footer = styled.footer`
    display:flex;
    padding:0;
    margin:0;
`

const DarkDiv = styled.div`
    padding:10px;
    background:grey;
`

const FeedSinglePage = ({data}) => {
    return (
        <div>
            {
                data.map((s, i) => {
                    return(
                        <DarkDiv>
                            <Card style={{ width: '100%', textAlign:'left'}} key={i}>
                                <Card.Header>
                                    <Row style={{alignItems:'center'}}>
                                        <Col sm={7}>
                                            <h3 style={{display:'flex'}}>{s.title}</h3>
                                        </Col>
                                        <Col sm>
                                            <p style={{textAlign:'right', margin:0}}>{s.author}</p>
                                        </Col>
                                    </Row>
                                </Card.Header>
                                {/* <Card.Img variant="top" src="holder.js/100px180" /> */}
                                <Card.Body>
                                    <h5 style={{textAlign:'left'}}>{s.body}</h5>
                                    <hr/>
                                    <Footer className="blockquote-footer">
                                        <text>{s.writeAt}</text>
                                    </Footer>
                                </Card.Body>
                            </Card>
                        </DarkDiv>

                    )
                })
            }
        </div>
    )
}

export default FeedSinglePage;