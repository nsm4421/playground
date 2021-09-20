<template>
    <span @click="clearAll">
        <p>전부 삭제하기</p>
    </span>
    
</template> 

<script>
export default{
    methods: {
        clearAll () {
            // 이벤트 발생
            this.$emit('clearAll');
        }
    }
}
</script>

<style scoped>
p{
    background: lightpink;
}
</style>