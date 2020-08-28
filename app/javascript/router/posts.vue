<template>
  <div class="flex content-center items-stretch">
    <div class="ml-64 self-auto"></div>
    <div class="ml-64 self-auto"></div>
    <div class="mt-8 text-left flex-1">
      <p class="w-full py-2">Create Post</p>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Creator</label>
        <input type="text" class="w-full px-3 py-2 border rounded-md" v-model="userId" />
      </div>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Title</label>
        <input type="text" class="w-full px-3 py-2 border rounded-md" v-model="title" />
      </div>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Content</label>
        <input type="text" class="w-full px-3 py-2 border rounded-md" v-model="content" />
      </div>
      <button
        @click="createPost"
        class="border bg-gray-200 rounded-lg mr-auto px-4 py-2 hover:bg-gray-400"
      >Submit</button>
    </div>
    <table class="border mt-4 mx-10 flex-1">
      <thead>
        <tr>
          <th class="h-12" colspan="4">POSTS</th>
        </tr>
        <tr>
          <th class="border px-4 py-2">Id</th>
          <th class="border px-4 py-2">Title</th>
          <th class="border px-4 py-2">Content</th>
          <th class="border px-4 py-2">Creator Email</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(post, index) in posts" :key="index">
          <th class="border px-4 py-2">{{ post.id }}</th>
          <th class="border px-4 py-2">{{ post.title }}</th>
          <th class="border px-4 py-2">{{ post.content }}</th>
          <th class="border px-4 py-2">{{ post.user.email }}</th>
        </tr>
      </tbody>
    </table>
    <div class="mr-64 self-auto"></div>
    <div class="mr-64 self-auto"></div>
  </div>
</template>
<script>
import gql from "graphql-tag";

const GET_POSTS = gql`
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
`;

const CREATE_POST = gql`
  mutation($input: CreatePostMutationInput!) {
    createPost(input: $input) {
      post {
        id
        title
        content
        user {
          id
          email
        }
      }
    }
  }
`;

export default {
  data() {
    return {
      title: "",
      content: "",
      userId: "",
    };
  },
  apollo: {
    posts: GET_POSTS,
  },
  methods: {
    createPost() {
      const userId = this.userId;
      const title = this.title;
      const content = this.content;
      this.userId = "";
      this.title = "";
      this.content = "";

      this.$apollo
        .mutate({
          mutation: CREATE_POST,
          variables: {
            input: {
              title,
              content,
              userId,
            },
          },
          // Update the cache with the result
          // The query will be updated with the optimistic response
          // and then with the real result of the mutation
          update: (store, { data: { createPost } }) => {
            // debugger;
            // Read the data from our cache for this query.
            const data = store.readQuery({ query: GET_POSTS });
            // Add our tag from the mutation to the end
            data.posts.push(createPost.post);
            // Write our data back to the cache.
            store.writeQuery({ query: GET_POSTS, data });
          },
        })
        .then((data) => {
          console.log(data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>
