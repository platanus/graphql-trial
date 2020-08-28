class Mutations::UpdateUserMutation < Mutations::BaseMutation
  null true

  # argument :user_id, ID, required: true, loads: Types::UserType
  argument :id, ID, required: true
  argument :email, String, required: false
  argument :password, String, required: false

  field :user, Types::UserType, null: true

  def resolve(id:, **args)
    user = User.find(id)
    user.update(args)
    { user: user }
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
