module Mutations::CommentMutations
  class CreateCommentMutation < Mutations::BaseMutation
    null true

    argument :user_id, ID, required: true
    argument :post_id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::ModelTypes::CommentType, null: true

    def resolve(user_id:, post_id:, content:)
      comment = Comment.create!(user_id: user_id, post_id: post_id, content: content)
      { comment: comment }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
