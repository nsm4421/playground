import Vue from "vue";
import VueRouter from "vue-router";
import power_ranking from "../components/power_ranking.vue";

Vue.use(VueRouter);

const routes = [
  {
    path : "/power_ranking",
    name : "power_ranking",
    component : power_ranking
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
