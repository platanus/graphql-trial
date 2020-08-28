<template>
  <div class="flex content-center items-stretch">
    <div class="ml-64 self-auto"></div>
    <div class="ml-64 self-auto"></div>
    <div class="mt-8 text-left flex-1">
      <p class="w-full py-2">Create User</p>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Email</label>
        <input
          type="text"
          class="w-full px-3 py-2 border rounded-md"
          v-model="email"
        />
      </div>
      <div class="w-full py-2">
        <label class="block text-xs font-medium">Password</label>
        <input
          type="text"
          class="w-full px-3 py-2 border rounded-md"
          v-model="password"
        />
      </div>
      <button
        @click="createUser"
        class="border bg-gray-200 rounded-lg mr-auto px-4 py-2 hover:bg-gray-400"
      >
        Submit
      </button>
    </div>
    <table class="border mt-4 mx-10 flex-1">
      <thead>
        <tr>
          <th class="h-12" colspan="3">USERS</th>
        </tr>
        <tr>
          <th class="border px-4 py-2">Id</th>
          <th class="border px-4 py-2">Email</th>
          <th class="border px-4 py-2">Number of posts</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(user, index) in users" :key="index">
          <th class="border px-4 py-2">{{ user.id }}</th>
          <th class="border px-4 py-2">{{ user.email }}</th>
          <th class="border px-4 py-2">{{ user.posts.length }}</th>
        </tr>
      </tbody>
    </table>
    <div class="mr-64 self-auto"></div>
    <div class="mr-64 self-auto"></div>
  </div>
</template>
<script>
import gql from "graphql-tag";

const GET_USERS = gql`
  query {
    users {
      id
      email
      posts {
        id
      }
    }
  }
`;

const CREATE_USER = gql`
  mutation($input: CreateUserMutationInput!) {
    createUser(input: $input) {
      user {
        id
        email
        posts {
          id
        }
      }
    }
  }
`;
export default {
  data() {
    return {
      email: "",
      password: ""
    };
  },
  apollo: {
    users: GET_USERS
  },
  methods: {
    createUser() {
      const email = this.email;
      const password = this.password;
      this.email = "";
      this.password = "";

      this.$apollo
        .mutate({
          mutation: CREATE_USER,
          variables: {
            input: {
              email,
              password
            }
          },
          // Update the cache with the result
          // The query will be updated with the optimistic response
          // and then with the real result of the mutation
          update: (store, { data: { createUser } }) => {
            // Read the data from our cache for this query.
            const data = store.readQuery({ query: GET_USERS });
            // Add our tag from the mutation to the end
            data.users.push(createUser.user);
            // Write our data back to the cache.
            store.writeQuery({ query: GET_USERS, data });
          }
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>
