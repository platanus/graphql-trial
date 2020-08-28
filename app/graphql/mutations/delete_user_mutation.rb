class Mutations::DeleteUserMutation < Mutations::BaseMutation
  null true

  # argument :user_id, ID, required: true, loads: Types::UserType
  argument :id, ID, required: true

  field :state, Boolean, null: true

  def resolve(id:)
    user = User.find(id)
    user.delete
    { state: true }
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
