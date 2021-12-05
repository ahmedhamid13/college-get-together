# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    ## CREATE MUTATION
    field :add_user, mutation: Mutations::Create::AddUser, description: "Add User"
    field :add_post, mutation: Mutations::Create::AddPost, description: "Add Post"
    field :add_comment, mutation: Mutations::Create::AddComment, description: "Add Comment"
    field :add_like, mutation: Mutations::Create::AddLike, description: "Add Like"
  end
end
