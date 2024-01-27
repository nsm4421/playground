import React from 'react'
import { Card } from '@material-ui/core'
import { CardContent } from '@material-ui/core'
import { Typography } from '@material-ui/core'
import { Grid } from '@material-ui/core'
import { Button } from '@material-ui/core'
import { Fab } from '@material-ui/core'
import { Dialog } from '@material-ui/core'
import { DialogActions } from '@material-ui/core'
import { DialogContent } from '@material-ui/core'
import { DialogTitle } from '@material-ui/core'
import { TextField } from '@material-ui/core'
import { withStyles } from '@material-ui/styles'
import { Link } from '@material-ui/core'
import { Link as RouterLink } from 'react-router-dom'
import TextTruncate from 'react-text-truncate'



const dbURL = "https://react-tutorial-a34d0-default-rtdb.firebaseio.com/"

const styles = theme=>({
    hidden : {
        display : 'none'
    },
    fab : {
        position : 'fixed',
        bottom : '20px',
        right : '20px'
    }
})

class Texts extends React.Component{
    
    constructor(props){
        super(props)
        this.state={
            fileName : '',
            fileContent : '',
            texts : {},
            textName : '',
            showDialog:false
        }
    }

    // firebase DB에서 GET요청 (데이터 조회)
    _get(){
        fetch(`${dbURL}/texts.json`)
        .then(res=>{
            // GET 요청 실패시
            if(res.status!=200){    
                throw new Error(res.statusText) 
            }
            // GET 요청 성공시
            return res.json()   
        })
        .then(texts=>this.setState({texts:(texts==null)?{}:texts}))
    }

    // firebase DB에서 POST요청 (데이터 삽입)
    _post(text){
        return fetch(`${dbURL}/texts.json`,{
            method:'POST',
            body:JSON.stringify(text)
        })
        .then(res=>{
            if (res.status!=200){
                throw new Error(res.statusText);
            }
            return res.json()
        })
        .then(data=>{   // POST 요청 성공시 재렌더링
            let nextState = this.state.texts;
            nextState[data.name] = text;
            this.setState({texts:nextState})
        })
    }

    
    // firebase DB에서 DELETE요청 (데이터 삭제)
    _delete(_id){
        return fetch(`${dbURL}/texts/${_id}.json`,{
            method:'DELETE'
        })
        .then(res=>{
            if (res.status!=200){
                throw new Error(res.statusText);
            }
            return res.json()
        })
        .then(()=>{   // 재렌더링
            let nextState=this.state.texts;
            delete nextState[_id]
            this.setState({texts:nextState})
        })
    }

    componentDidMount(){
        this._get()
    }
    
    handleDialogToggle=()=>this.setState({
        showDialog:!this.state.showDialog,
        fileName : '',
        fileContent : '',
        textName : ''
    })

    handleValueChange=(e)=>{
        let nextState={};
        nextState[e.target.name] = e.target.value;
        this.setState(nextState)
    }

    handleSubmit=()=>{
        const data = {
            textName : this.state.textName,
            fileContent : this.state.fileContent
        }
        this.handleDialogToggle();
        if (!data.textName && !data.fileContent){
            return
        } else{
            this._post(data);
            this.state.textName=""
            this.state.fileContent=""
        }
    }

    handleDelete=(_id)=>{
        this._delete(_id)
    }

    handleFileChange=(e)=>{
        let reader = new FileReader();
        reader.onload=()=>{
            let text = reader.result;
            this.setState({fileContent:text})
        }
        reader.readAsText(e.target.files[0], "EUC-KR")
        this.setState({fileName:e.target.value})
    }

    render(){

        const {classes} = this.props;

        return (
            <div>
      

                {Object.keys(this.state.texts).map((_id)=>{
                    const text = this.state.texts[_id]
                    return (
            
                        <Card key={_id}>
                            <CardContent>
                                 
                            <Grid container>
                                <Grid item xs={6}>
                                <Typography variant="h5">
                                    File : {text.textName+".txt"}
                                </Typography>
                                <Typography color="textSecondary" gutterBottom>
                                    Content : {text.fileContent.substring(0, 24)+"..."}
                                </Typography>
                                </Grid>    
                                <Grid item xs={3}>
                                    <Link component={RouterLink} to={`detail/${_id}`} >
                                        <Button variant="contained" color="primary">
                                            Detail
                                        </Button>
                                    </Link>
                                </Grid>    
                                <Grid item xs={3}>
                                    <Button variant="contained" color="primary" 
                                        onClick={()=>this.handleDelete(_id)}>
                                        Delete
                                    </Button>
                                </Grid>    
                            </Grid> 
                            </CardContent> 
                        </Card>
              
                    )
                })}


                <Fab color="primary" className={classes.fab} onClick={this.handleDialogToggle}>
                    Add
                </Fab>

                <Dialog open={this.state.showDialog} onClose={this.handleDialogToggle}>
                    <DialogTitle>Add Text</DialogTitle>
                    <DialogContent>
                        <TextField label="Text File Name" type="text" name="textName" onChange={this.handleValueChange}/>
                        <br/><br/>
                        <input className={classes.hidden} accept="text/plain" id="raised-button-file" type="file" file={this.state.file} value={this.state.fileName}
                        onChange={this.handleFileChange}/>
                        <label htmlFor="raised-button-file">
                            <Button variant="contained" color="primary" component="span" name="file">
                                {this.state.fileName===""?"Choose Text File":this.state.fileName}
                            </Button>
                        </label>
                        <TextTruncate
                            line={1}
                            truncateText="..."
                            text={this.state.fileContent}/>                      
                    </DialogContent>
                    <DialogActions>
                        <Button variant='contained' color="primary" onClick={this.handleSubmit}>Submit</Button>
                        <Button variant='contained' color="primary" onClick={this.handleDialogToggle}>Close</Button>
                    </DialogActions>
                </Dialog>

            </div>
        )
    }
}

export default withStyles(styles)(Texts);