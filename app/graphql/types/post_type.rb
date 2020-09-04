module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false, description: 'identifier'
    field :title, String, null: false
    field :content, String, null: false
    field :user, Types::UserType, null: true
    field :comments, [ModelTypes::CommentType], null: false

    def user
      # binding.pry
      # .batch uses by default a nil match. This means that by default if a post does not have
      # a user it will match nil with that post.
      BatchLoader::GraphQL.for(object.user_id).batch do |user_ids, loader|
        # binding.pry
        User.where(id: user_ids).each { |user| loader.call(user.id, user) }
      end
    end

    def comments
      # binding.pry
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |posts_ids, loader|
        # binding.pry
        Comment.where(post_id: posts_ids).each do |comment|
          # binding.pry
          loader.call(comment.post_id) do |comment_array|
            # binding.pry
            comment_array << comment
          end
        end
      end
    end
  end
end
