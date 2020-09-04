module Mutations::PostMutations
  class UpdatePostMutation < Mutations::BaseMutation
    null true

    argument :id, ID, required: true
    argument :user_id, ID, required: false
    argument :title, String, required: false
    argument :content, String, required: false

    field :post, Types::PostType, null: true

    def resolve(id:, **args)
      post = Post.find(id)
      post.update!(args)
      { post: post }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
