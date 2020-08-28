module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
                               description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
    field :create_user, mutation: Mutations::UserMutations::CreateUserMutation
    field :update_user, mutation: Mutations::UpdateUserMutation
    field :delete_user, mutation: Mutations::DeleteUserMutation
    field :create_post, mutation: Mutations::PostMutations::CreatePostMutation
    field :update_post, mutation: Mutations::PostMutations::UpdatePostMutation
  end
end
