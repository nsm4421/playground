import React from 'react';
import {post} from 'axios';

class ChangePassword extends React.Component {
    constructor(props){
        super(props)
        this.state = {
            user_id : '',
            new_password : ''
        }
    }

    ChangePassword = () => {
        const url = 'auth/changePassword';
        const formData = new FormData();
        const config = {
            headers : {
                'content-type' : 'multipart/form-data'
            }
        }
        formData.append('user_id', this.state.user_id);
        formData.append('new_password', this.state.new_password);
        return post(url, formData, config);
    }

    handleFormSubmit = (event) => {
        event.preventDefault();
        this.ChangePassword().then((res)=> {
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
                <h1>비번수정</h1>
                <label>아이디</label>
                <input type="text" name="user_id"  value={this.state.user_id} onChange={this.handleValueChange}/>
                <label>새로운 비번</label>
                <input type="password" name="new_password"  value={this.state.new_password} onChange={this.handleValueChange}/>
                <button type="submit">비번수정하시겠습니까??</button>
            </form>
        )
    }
}


export default ChangePassword;