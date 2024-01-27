<template>
  <div id="app">
    <!-- 컴퍼넌트 -->
    <my-header></my-header>
    <my-input v-on:addToDo="addToDo"></my-input>
    <my-list v-bind:propsdata="할일들" @removeToDo="removeToDo"></my-list>
    <my-footer v-on:clearAll="clearAll"></my-footer>
  </div>
</template>

<script>
// 컴퍼넌트 import하기
import MyHeader from './components/MyHeader.vue'
import MyInput from './components/MyInput.vue'
import MyList from './components/MyList.vue'
import MyFooter from './components/MyFooter.vue'

export default {
  name : 'app',
  data(){
    return {
      할일들 : []
    }
  },
  // 메서드
  methods : {
    addToDo(할일){
      localStorage.setItem(할일, 할일);
      this.할일들.push(할일);
      console.log(할일, " 추가")
    },
    removeToDo(할일, 인덱스){
      localStorage.removeItem(할일);
      this.할일들.splice(인덱스, 1);
      console.log(할일, " 삭제")
    },
    clearAll(){
      localStorage.clear();
      this.할일들 = [];
      console.log("전체삭제")
    }
  },
  created(){
    console.log("앱실행")
    if (localStorage.length>0){
      for (var i=0;i<localStorage.length;i++){
        this.할일들.push(localStorage.key(i));
      }
    }
  },
  // 사용할 컴퍼넌트  
  components : {
    'MyHeader' : MyHeader,
    'MyInput' : MyInput,
    'MyList' : MyList,
    'MyFooter' : MyFooter
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
