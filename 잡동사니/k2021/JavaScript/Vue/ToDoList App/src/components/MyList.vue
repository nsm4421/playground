<template>
    <section>
        <ul>
            <li v-for="(할일,인덱스) in propsdata" :key="할일" class="shadow">
                <!-- 체크표시 아이콘 -->
                <i class="checkBtn fa fa-check" aria-hidden="true"></i>
                {{할일}}                
                <span class="removeBtn" type="button" @click="removeToDo(할일,인덱스)">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                </span>
            </li>
        </ul>
    </section>
</template>

<script>
export default{
    props : ['propsdata'],
    methods : {
        removeToDo (할일, 인덱스) {
            this.$emit('removeToDo', 할일, 인덱스);
        }
    }
}
</script>

<style scoped>


ul li {
  display: block;
  margin: 10px;
  padding : 3px;
  background: lemonchiffon;
  text-align: left;
  font-size: 18px;
  border-radius: 10px;
}

.checkBtn {
    background: rgb(238, 232, 146);
    margin-right : 10px;
    border-radius: 10px;
}

.removeBtn {
    background: lightpink;
    margin-left: 30px;
}


</style>