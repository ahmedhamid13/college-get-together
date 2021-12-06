# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    ## CREATE MUTATION
    field :create_user, mutation: Mutations::Create::AddUser, description: "Add User"
    field :create_post, mutation: Mutations::Create::AddPost, description: "Add Post"
    field :create_comment, mutation: Mutations::Create::AddComment, description: "Add Comment"
    field :create_like, mutation: Mutations::Create::AddLike, description: "Add Like"
    field :create_follow, mutation: Mutations::Create::AddFollow, description: "Add Follow"
  end
end
