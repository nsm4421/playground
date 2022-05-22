import create from 'zustand';

const UserStore = create((set)=>({
    user : {},
    setUser(u){set(()=>({user:u}))}
}))

export default UserStore;


