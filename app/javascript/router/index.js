import Vue from "vue";
import VueRouter from "vue-router";
import Users from "./users";
import Posts from "./posts";
import Comments from "./comments";

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
    },
    {
      path: "/comments",
      name: "comments",
      component: Comments
    }
  ]
});

export default router;
