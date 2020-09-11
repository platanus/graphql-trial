<template>
  <div class="font-family:Roboto mb-4">
    <p>{{ message }}</p>
    <div class="bg-white bg-opacity-200">
      <router-link
        to="users"
        tag="button"
        class="border bg-gray-200 rounded-lg mx-3 px-4 py-2 hover:bg-gray-400"
      >users</router-link>
      <router-link
        to="posts"
        tag="button"
        class="border bg-gray-200 rounded-lg mx-3 px-4 py-2 hover:bg-gray-400"
      >posts</router-link>
      <router-link
        to="comments"
        tag="button"
        class="border bg-gray-200 rounded-lg mx-3 px-4 py-2 hover:bg-gray-400"
      >commnets</router-link>
    </div>
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import gql from "graphql-tag";

export default {
  data: function () {
    return {
      message: "GraphQL Basics",
      querySelected: true,
    };
  },
  computed: {
    mutationEnable() {
      return !this.querySelected;
    },
  },
  methods: {
    enableMutation() {
      this.querySelected = false;
    },
    enableQuery() {
      this.querySelected = true;
    },
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

div {
  text-align: center;
}

.main {
  background-color: #f7f5fa;
}
</style>
