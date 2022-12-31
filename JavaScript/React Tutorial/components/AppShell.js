import React from 'react'
import { Link, withStyles } from '@material-ui/core'
import { AppBar } from '@material-ui/core'
import { Drawer } from '@material-ui/core'
import { MenuItem} from '@material-ui/core'
import { Link as RouterLink } from 'react-router-dom'

const myStyle={
    root : {
        flexGrow : 1
    },
    menuButton : {
        marginRight : 'auto',  // 왼쪽 정렬
    }
}

class AppShell extends React.Component{
    constructor(props){
        super(props);
        this.state={
            toggle:false
        }
    }

    handleDrawerToggle=()=>this.setState({toggle:!this.state.toggle})

    render(){
        const classes = this.props;
        return(
            <div className={classes.root}>
                
                <AppBar position='static'>
                    <h2 color="inherit" onClick={this.handleDrawerToggle}>React Tutorial</h2>
                </AppBar>

                <Drawer open={this.state.toggle}>
                    <MenuItem onClick={this.handleDrawerToggle} style={classes.menuButton}>
                        <Link to ="/" component={RouterLink}>Home</Link>
                    </MenuItem>
                    <MenuItem onClick={this.handleDrawerToggle} style={classes.menuButton}>
                        <Link to ="/texts" component={RouterLink}>Texts</Link>
                    </MenuItem>
                    <MenuItem onClick={this.handleDrawerToggle} style={classes.menuButton}>
                        <Link to ="/result" component={RouterLink}>Result</Link>
                    </MenuItem>
                </Drawer>
            </div>       
        )
    }
}

export default withStyles(myStyle)(AppShell);