module Mutations::PostMutations
  class CreatePostMutation < Mutations::BaseMutation
    null true

    argument :user_id, ID, required: true
    argument :title, String, required: true
    argument :content, String, required: true

    field :post, Types::PostType, null: true
    # field :errors, [String], null: false
    # type Types::UserType

    def resolve(user_id:, title:, content:)
      post = Post.create!(user_id: user_id, title: title, content: content)
      { post: post }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
