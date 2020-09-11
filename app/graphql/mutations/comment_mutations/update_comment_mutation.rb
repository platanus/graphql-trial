module Mutations::CommentMutations
  class UpdateCommentMutation < Mutations::BaseMutation
    null true

    argument :id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::ModelTypes::CommentType, null: true

    def resolve(id:, **args)
      comment = Comment.find(id)
      binding.pry
      comment.update!(args)
      { comment: comment }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
