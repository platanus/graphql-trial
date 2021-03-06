import Vue from "vue";
import App from "../app.vue";
import VueApollo from "vue-apollo";
import "../css/application.css";
import router from "../router";
import { ApolloClient } from "apollo-client";
import { ApolloLink, concat, split } from "apollo-link";
import { createHttpLink } from "apollo-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";

// HTTP connection to the API
const httpLink = createHttpLink({
  // You should use an absolute URL here
  uri: "http://localhost:3000/graphql"
});

// Cache implementation
const cache = new InMemoryCache();

// Create the apollo client
const apolloClient = new ApolloClient({
  link: httpLink,
  cache
});

const apolloProvider = new VueApollo({
  defaultClient: apolloClient
});

document.addEventListener("DOMContentLoaded", () => {
  Vue.use(VueApollo);
  const app = new Vue({
    el: "#app",
    // components: { App },
    // inject apolloProvider here like vue-router or vuex
    apolloProvider,
    router,
    render: h => h(App)
  });

  return app;
});

// Vue.use(VueApollo);
// const app = new Vue({
//   el: "#app",
//   components: { App },
//   // inject apolloProvider here like vue-router or vuex
//   apolloProvider,
//   render: h => h(App)
// });

// app.$mount();
