<template>
<div>
    <!-- InputBox -->
    <input type="text" v-model="할일" placeholder="해야될 일 입력 ㄱㄱ" v-on:keyup.enter="addToDo">
    <!-- 아이콘 -->
    <span class="addContainer" v-on:click="addToDo">
        <i class="addBtn fa fa-plus" aria-hidden="true"></i>
    </span>
   
</div>
</template>

<script>
export default{
    data(){
        return {
            할일:''
        }
    },
    methods: {
        addToDo () {
            if (this.할일 != ''){
                var 넣을값 = this.할일 && this.할일.trim();
                // 이벤트 발생
                this.$emit('addToDo', 넣을값);
                this.할일='';
            } else{
                // 예외처리
                alert('InputBox 값이 공란인데?');
            }
        }
    }
}
</script>

<style scoped>
input { font-size : 20px;  width: 60%; padding: 10px 20px; margin: 5px 0; box-sizing: border-box; }
input[type="text"] { border: none; border-bottom: solid 2px #D2691E; }

</style>