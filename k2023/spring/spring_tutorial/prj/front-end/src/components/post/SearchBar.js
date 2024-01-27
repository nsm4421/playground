import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import DirectionsIcon from '@mui/icons-material/Directions';
import { Box } from "@mui/system";
import { Link } from "react-router-dom";
import { Button, Typography } from "@mui/material";
import CreateIcon from '@mui/icons-material/Create';
import DynamicFeedIcon from '@mui/icons-material/DynamicFeed';

const SearchBar = () => {
  return (
    <Paper component="form" sx={{ p: '2px 4px', display: 'flex', alignItems: 'center', width: '80%' }}>
      <IconButton sx={{ p: '10px' }} aria-label="menu">
        <MenuIcon />
      </IconButton>
      <InputBase
        sx={{ ml: 1, flex: 1 }}
        placeholder="Search Google Maps"
        inputProps={{ 'aria-label': 'search google maps' }}
      />
      <IconButton type="button" sx={{ p: '10px' }} aria-label="search">
        <SearchIcon />
      </IconButton>
      <Divider sx={{ height: 28, m: 0.5 }} orientation="vertical" />
      <IconButton color="primary" sx={{ p: '10px' }} aria-label="directions">
        <DirectionsIcon />
      </IconButton>

      <Typography variant="h5" component="h5">
                    <DynamicFeedIcon/> 포스팅     
                </Typography>

                <SearchBar/>
                

        <Box>
            <Link to="/post/write">
                <Button variant="contained" color="success" sx={{marginRight:'10px'}}>
                        <CreateIcon sx={{marginRight:'10px'}}/>포스팅 쓰기
                </Button>
            </Link>
        </Box>
    


    </Paper>
  );
}
export default SearchBar; 