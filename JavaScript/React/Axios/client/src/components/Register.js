import React from 'react';
import {post} from 'axios';

class Register extends React.Component {
    constructor(props){
        super(props)
        this.state = {
            user_id : '',
            password : '',
            email : '',
            nickname : '',
        }
    }

    register = () => {
        const url = 'auth/register';
        const formData = new FormData();
        const config = {
            headers : {
                'content-type' : 'multipart/form-data'
            }
        }
        formData.append('user_id', this.state.user_id);
        formData.append('password', this.state.password);
        formData.append('email', this.state.email);
        formData.append('nickname', this.state.nickname);

        return post(url, formData, config);
    }

    handleFormSubmit = (event) => {
        event.preventDefault();
        this.register().then((res)=> {
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
                <h1>회원가입</h1>
                <label>아이디</label>
                <input type="text" name="user_id" value={this.state.user_id} onChange={this.handleValueChange}/>
                <label>패스워드</label>
                <input type="password" name="password" value={this.state.password} onChange={this.handleValueChange}/>
                <label>닉네임</label>
                <input type="text" name="nickname" value={this.state.nickname} onChange={this.handleValueChange}/>
                <label>Email</label>
                <input type="email" name="email"  value={this.state.email} onChange={this.handleValueChange}/>
          
                <button type="submit">회원가입</button>
            </form>
        )

    }
}

export default Register;