import create from 'zustand';

const WindowStore = create((set)=>({
    size : {
      width : 0,
      height : 0,
    },
    setSize(s){set(()=>({size:s}))}
}))

export default WindowStore;


