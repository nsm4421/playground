import React from 'react';

class User extends React.Component{
    render(){
        return ( 
        <div>
            <UserProfile 
                lol_id = {this.props.user_id}
                user_id = {this.props.user_id}/>
            <UserInfo
                position = {this.props.position}
                greeting = {this.props.greeting}/>
        </div>
        )       
    }
}


class UserProfile extends React.Component{
    render(){
        return(
            <div>
                <h4>롤아이디</h4>
                <p> {this.props.lol_id} </p>
                <h4>아이디</h4>
                <p> {this.props.user_id} </p>                
            </div>
        )
    }
}

class UserInfo extends React.Component{
    render(){
        return(
            <div>
                <h4>포지션</h4>
                <p> {this.props.position} </p>
                <h4>인사말</h4>
                <p> {this.props.greeting} </p>              
            </div>
        )
    }
}



export default User;