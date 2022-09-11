import styled from 'styled-components';

const GrayDiv = styled.div`
    background:grey;
    padding:20px;
    color:white;
`

const ImageBox = styled.img`
    src:${props=>props.src};
    width:80%;
`

const MainBackground = () => {
    return (
        <GrayDiv>
            <ImageBox src={`${process.env.PUBLIC_URL}/images/test_image1.jpg`}/>
        </GrayDiv>
    )
}

const Home =  () => {
    return (
        <div>
            <MainBackground/>
            <GrayDiv>
                <h3>Description</h3>
                <span>details</span>
            </GrayDiv>
        </div>
    )
};

export default Home;