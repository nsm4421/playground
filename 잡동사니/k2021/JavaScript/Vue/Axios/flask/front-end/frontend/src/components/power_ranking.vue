<template>


    <div>        
        <img src="../assets/chovy.jpg"/>
        <img src="../assets/doinb.jpg">
        <img src="../assets/faker.jpg">
        <img src="../assets/show-maker.jpg"> 

        <div v-for="(player,idx) in players" :key=idx>
             <button v-on:click="cickButton(idx)"> {{player.player}}</button>
             <p>{{player.count}}</p>
        </div>
       
    </div>
 
    

</template>

<script>
import Axios from 'axios';
// request('axios');

export default {
    name : 'power-ranking',
    data(){
        return {            
            players : [{
                'player' : 'chovy',
                'src' : '../assets/chovy.jpg',
                'count' : 0
            },{
                'player' : 'doinb',
                'src' : '../assets/doinb.jpg',
                'count' : 0
            },{
                'player' : 'faker',
                'src' : '../assets/faker.jpg',
                'count' : 0
            },{
                'player' : 'show-maker',
                'src' : '../assets/show-maker.jpg',
                'count' : 0
            },
            ]
        }
    },
    methods : {
        // count 증가
        addCount(idx){
            this.players[idx].count++;        
        },
        // flask로 정보 보내기
        sendPost(idx){
            Axios('http://127.0.0.1:5000/',{
                method : 'POST',
                params : {
                    player : this.players[idx].player,
                    count : this.players[idx].count
                }
            })
            .then((res)=>{
                console.log(res.data);
            })
        },
        cickButton(idx){
            this.addCount(idx);
            this.sendPost(idx);
        }
    }
};


</script>