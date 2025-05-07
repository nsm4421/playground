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

// firebase db 주소
const dbURL = "https://react-tutorial-a34d0-default-rtdb.firebaseio.com/"

const myStyle = theme=>({
    Fab : {
        position :'fixed',
        bottom : '20px',
        right : '20px'
    }
})

class Result extends React.Component{

    constructor(){
        super();
        this.state={
            words:{},
            showDialog : false,
            word : '',
            weight : ''
        }
    }

    // firebase DB에서 GET요청 (데이터 조회)
    _get(){
        fetch(`${dbURL}/words.json`)
        .then(res=>{
            // GET 요청 실패시
            if(res.status!=200){    
                throw new Error(res.statusText) 
            }
            // GET 요청 성공시
            return res.json()   
        })
        .then(words=>this.setState({words:words}))
    }

    // firebase DB에서 POST요청 (데이터 삽입)
    _post(word){
        return fetch(`${dbURL}/words.json`,{
            method:'POST',
            body:JSON.stringify(word)
        })
        .then(res=>{
            if (res.status!=200){
                throw new Error(res.statusText);
            }
            return res.json()
        })
        .then(data=>{   // POST 요청 성공시 재렌더링
            let nextState = this.state.words;
            nextState[data.name] = word;
            this.setState({words:nextState})
        })
    }

    // firebase DB에서 DELETE요청 (데이터 삭제)
    _delete(_id){
        return fetch(`${dbURL}/words/${_id}.json`,{
            method:'DELETE'
        })
        .then(res=>{
            if (res.status!=200){
                throw new Error(res.statusText);
            }
            return res.json()
        })
        .then(()=>{   // 재렌더링
            let nextState=this.state.words;
            delete nextState[_id]
            this.setState({words:nextState})
        })
    }
    
    // 컴퍼넌트가 마운트 되면 firebase로 GET요청 쏘기
    componentDidMount(){
        this._get() 
    }

    handleDialogToggle=()=>this.setState({showDialog:!this.state.showDialog})

    handleValueChange=(e)=>{
        let nextState={};
        nextState[e.target.name] = e.target.value;
        this.setState(nextState)
    }

    handleSubmit=()=>{
        const data = {
            word : this.state.word,
            weight : this.state.weight
        }
        this.handleDialogToggle();
        if (!data.word && !data.weight){
            return
        } else{
            this._post(data);
            this.state.word=""
            this.state.weight=""
        }
    }

    handleDelete=(_id)=>{
        this._delete(_id)
    }

    render(){

        const classes = this.props;

        return (
            <div>
                <h1>Result</h1>
                <hr/>
                {Object.keys(this.state.words).map(_id => {
                    const word = this.state.words[_id]
                    return (
                        <div key={_id}>
                            <Card>
                                <CardContent>
                                
                                    
                                    <Grid container>

                                        <Grid item xs={6}>
                                            <Typography variant="h5" component="h2">
                                            {word.word}
                                            </Typography>  
                                            <Typography color="textSecondary" gutterBottom>
                                                Weight : {word.weight}
                                            </Typography>  
                                        </Grid>                                      

                                        <Grid item xs={6}>
                                            <Button varint="contained" color="primary" 
                                                onClick={()=>this.handleDelete(_id)}>Delete</Button>
                                        </Grid>             

                                    </Grid>


                                </CardContent>
                            </Card>
                        </div>
                    )
                })}                              

                <Fab color="primary" className={classes.Fab}
                    onClick={()=>this.handleDialogToggle()}>Add</Fab>
                
                <Dialog open={this.state.showDialog} onClose={this.handleDialogToggle}>
                    <DialogTitle>Add Word</DialogTitle>
                    
                    <DialogContent>
                        <TextField label="word to add" type="text" name="word" value={this.state.word}
                        onChange={this.handleValueChange}/>
                        <TextField label="weight to add" type="text" name="weight" value={this.state.weight}
                        onChange={this.handleValueChange}/>
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

export default withStyles(myStyle)(Result);