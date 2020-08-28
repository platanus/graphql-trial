module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false, description: 'identifier'
    field :email, String, null: false, description: 'unique email'
    field :encrypted_password, String, null: false, description: 'secret password'
    field :email_with_id, String, null: false
    field :posts, [Types::PostType], null: true

    def email_with_id
      "#{object.email}-#{object.id}"
    end

    def posts
      # binding.pry
      # the default_value must be an empty array because it indicates that a user by default has
      # no posts. If the default is set to null the loader will raise an error
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |user_ids, loader|
        # binding.pry
        Post.where(user_id: user_ids).each do |post|
          # binding.pry
          # here we need the post_array to be set, if nil -> post_array << post fails
          loader.call(post.user_id) do |post_array|
            # binding.pry
            post_array << post
          end
        end
      end
    end
  end
end
