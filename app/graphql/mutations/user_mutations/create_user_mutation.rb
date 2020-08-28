module Mutations::UserMutations
  class CreateUserMutation < Mutations::BaseMutation
    null true

    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    # field :errors, [String], null: false
    # type Types::UserType

    def resolve(email:, password:)
      user = User.create!(email: email, password: password)
      { user: user }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
      # {
      #   user: user,
      #   errors: []
      # }
      # if user.save
      #   {
      #     user: user,
      #     errors: []
      #   }
      # else
      #   {
      #     user: nil,
      #     errors: user.errors.full_messages
      #   }
      # end
    end
  end
end
