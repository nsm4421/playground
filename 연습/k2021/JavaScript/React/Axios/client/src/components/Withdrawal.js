import React from 'react';
import {post} from 'axios';

class Withdrawal extends React.Component {
    constructor(props){
        super(props)
        this.state = {
            user_id : '',

        }
    }

    withdrawal = () => {
        const url = 'auth/withdrawal';
        const formData = new FormData();
        const config = {
            headers : {
                'content-type' : 'multipart/form-data'
            }
        }
        formData.append('user_id', this.state.user_id);
        return post(url, formData, config);
    }

    handleFormSubmit = (event) => {
        event.preventDefault();
        this.withdrawal().then((res)=> {
            console.log(res.data);
        })
    }

    handleValueChange = (event) => {
        let nextState = {};
        nextState[event.target.name] = event.target.value;
        this.setState(nextState);
    }

    render () {
        return (
            <form onSubmit={this.handleFormSubmit}>
                <h1>회원탈퇴</h1>
                <label>아이디</label>
                <input type="text" name="user_id"  value={this.state.user_id} onChange={this.handleValueChange}/>
                <button type="submit">탈퇴하시겠습니까?</button>
            </form>
        )
    }
}


export default Withdrawal;