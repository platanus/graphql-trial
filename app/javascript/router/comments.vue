<template>
  <div class="comments-class flex content-center items-stretch">
    <div class="mt-8 text-left flex-1">
      <p class="w-full py-2">Create Comment</p>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Content</label>
        <input type="text" class="w-full px-3 py-2 border rounded-md" v-model="content" />
      </div>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Creator</label>
        <input type="text" class="w-full px-3 py-2 border rounded-md" v-model="userId" />
      </div>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Post</label>
        <input type="text" class="w-full px-3 py-2 border rounded-md" v-model="postId" />
      </div>
      <button
        @click="createComment"
        class="border bg-gray-200 rounded-lg mr-auto px-4 py-2 hover:bg-gray-400"
      >Submit</button>
    </div>
    <table class="border mt-4 mx-10 flex-1">
      <thead>
        <tr>
          <th class="h-12" colspan="4">COMMENTS</th>
        </tr>
        <tr>
          <th class="border px-4 py-2">Id</th>
          <th class="border px-4 py-2">Content</th>
          <th class="border px-4 py-2">Creator Email</th>
          <th class="border px-4 py-2">Post Title</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(comment, index) in comments" :key="index">
          <th class="border px-4 py-2">{{ comment.id }}</th>
          <th class="border px-4 py-2">{{ comment.content }}</th>
          <th class="border px-4 py-2">{{ comment.user.email }}</th>
          <th class="border px-4 py-2">{{ comment.post.title }}</th>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
import gql from "graphql-tag";

const GET_COMMENTS = gql`
  query get_comments {
    comments {
      id
      content
      user {
        id
        email
      }
      post {
        id
        title
      }
    }
  }
`;

const CREATE_COMMENT = gql`
  mutation($input: CreateCommentMutationInput!) {
    createComment(input: $input) {
      comment {
        id
        content
        user {
          id
          email
        }
        post {
          id
          title
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
    comments: GET_COMMENTS,
  },
  methods: {
    createComment() {
      const userId = this.userId;
      const postId = this.postId;
      const content = this.content;
      this.userId = "";
      this.postId = "";
      this.content = "";

      this.$apollo
        .mutate({
          mutation: CREATE_COMMENT,
          variables: {
            input: {
              content,
              userId,
              postId,
            },
          },
          // Update the cache with the result
          // The query will be updated with the optimistic response
          // and then with the real result of the mutation
          update: (store, { data: { createComment } }) => {
            // debugger;
            // Read the data from our cache for this query.
            const data = store.readQuery({ query: GET_COMMENTS });
            // Add our tag from the mutation to the end
            data.comments.push(createComment.comment);
            // Write our data back to the cache.
            store.writeQuery({ query: GET_COMMENTS, data });
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
<style lang="scss" scoped>
.comments-class {
  margin-left: 20%;
  margin-right: 20%;
}
</style>