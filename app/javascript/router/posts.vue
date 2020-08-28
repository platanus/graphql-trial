<template>
  <div class="flex flex-col content-center items-center">
    <table class="border mt-4">
      <thead>
        <tr>
          <th class="h-12" colspan="4">POSTS</th>
        </tr>
        <tr class="border">
          <th class="px-4 py-2">Id</th>
          <th class="px-4 py-2">Author</th>
          <th class="px-4 py-2">Title</th>
          <th class="px-4 py-2">Content</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(post, index) in posts" :key="index">
          <th class="border px-4 py-2">{{ post.id }}</th>
          <th class="border px-4 py-2">{{ post.user.email }}</th>
          <th class="border px-4 py-2">{{ post.title }}</th>
          <th class="border px-4 py-2">{{ post.content }}</th>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
import gql from "graphql-tag";

export default {
  apollo: {
    posts: gql`
      query {
        posts {
          id
          title
          content
          user {
            id
            email
          }
        }
      }
    `
  }
};
</script>
