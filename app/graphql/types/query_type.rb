module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
                               description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :users, [Types::UserType], null: false, description: "Returns a list of users"
    field :user, Types::UserType, null: false, description: 'Returns a user' do
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end

    field :posts, [Types::PostType], null: false, description: "Returns a list of Posts"
    field :post, Types::PostType, null: false, description: 'Returns a Post' do
      argument :id, ID, required: true
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find(id)
    end
  end
end
