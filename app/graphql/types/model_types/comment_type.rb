module Types::ModelTypes
  class CommentType < Types::BaseObject
    field :id, ID, null: false, description: 'identifier'
    field :content, String, null: false
    field :user, Types::UserType, null: true
    field :post, Types::PostType, null: false

    def user
      # binding.pry
      # .batch uses by default a nil match. This means that by default if a post does not have
      # a user it will match nil with that post.
      BatchLoader::GraphQL.for(object.user_id).batch do |user_ids, loader|
        # binding.pry
        User.where(id: user_ids).each { |user| loader.call(user.id, user) }
      end
    end

    def post
      # binding.pry
      # .batch uses by default a nil match. This means that by default if a post does not have
      # a user it will match nil with that post.
      BatchLoader::GraphQL.for(object.post_id).batch(default_value: nil) do |posts_ids, loader|
        # binding.pry
        Post.where(id: posts_ids).each { |post| loader.call(post.id, post) }
      end
    end
  end
end
