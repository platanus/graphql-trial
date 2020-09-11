module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::LoginMutation
    field :create_user, mutation: Mutations::UserMutations::CreateUserMutation
    field :update_user, mutation: Mutations::UserMutations::UpdateUserMutation
    field :delete_user, mutation: Mutations::UserMutations::DeleteUserMutation
    field :create_post, mutation: Mutations::PostMutations::CreatePostMutation
    field :update_post, mutation: Mutations::PostMutations::UpdatePostMutation
    field :create_comment, mutation: Mutations::CommentMutations::CreateCommentMutation
    field :update_comment, mutation: Mutations::CommentMutations::UpdateCommentMutation
  end
end
