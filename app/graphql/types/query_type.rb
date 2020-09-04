module Types
  class QueryType < Types::BaseObject
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
