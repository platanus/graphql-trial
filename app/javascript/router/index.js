import Vue from "vue";
import VueRouter from "vue-router";
import Users from "./users";
import Posts from "./posts";

Vue.use(VueRouter);

const router = new VueRouter({
  base: "/",
  routes: [
    {
      path: "/users",
      name: "users",
      component: Users
    },
    {
      path: "/posts",
      name: "posts",
      component: Posts
    }
  ]
});

export default router;
