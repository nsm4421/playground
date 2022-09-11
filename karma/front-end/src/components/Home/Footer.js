import styled from 'styled-components';



const FooterDiv = styled.div`
    height:50px;    
    color:grey;
    display:flex;
    padding:10px;
    font-size:5px;
    justify-content:space-between;
`

const Footer = () => {
    return (
        <div>    
            <FooterDiv>
                <span>karma</span>
                <span>nsm4421@naver.com</span>
            </FooterDiv>
        </div>
    )
}

export default Footer;