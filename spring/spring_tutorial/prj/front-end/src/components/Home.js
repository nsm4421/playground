import { Container } from "@mui/system";

const { Typography, Tooltip } = require("@mui/material")

const Home=()=>{

    const githubRepositoryLink = "https://github.com/nsm4421/Prj";

    return(
        <>
        <Container>
            <Typography variant="h5" sx={{marginTop:"10vh"}}>
                커뮤니티 사이트 만들기
            </Typography>

            <Typography paragraph sx={{marginTop:"5vh"}}>
                <Typography fontSize={'large'}>Front-End</Typography>
                <Typography fontSize={'small'}>React</Typography>
            </Typography>

            <Typography paragraph sx={{marginTop:"5vh"}}>
                <Typography fontSize={'large'}>Back-End</Typography>
                <Typography fontSize={'small'}>Spring Boot</Typography>
            </Typography>

            <Typography paragraph sx={{marginTop:"5vh"}}>
                <Typography fontSize={'large'}>Github Repository</Typography>
                <Tooltip title="move">
                    <Typography sx={{display:"inline"}} fontSize={'small'}>
                        <a href={githubRepositoryLink}>
                            {githubRepositoryLink}
                        </a>
                    </Typography>
                </Tooltip>
            </Typography>
        </Container>
        </>
    )
}

export default Home;