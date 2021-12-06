# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    ## CREATE MUTATION
    field :create_user, mutation: Mutations::Create::AddUser, description: "Create User"
    field :create_post, mutation: Mutations::Create::AddPost, description: "Create Post"
    field :create_comment, mutation: Mutations::Create::AddComment, description: "Create Comment"
    field :create_like, mutation: Mutations::Create::AddLike, description: "Create Like"
    field :create_follow, mutation: Mutations::Create::AddFollow, description: "Create Follow"

    ## Update MUTATION
    field :update_user, mutation: Mutations::Update::ModifyUser, description: "Update User"
    field :update_post, mutation: Mutations::Update::ModifyPost, description: "Update Post"
    field :update_comment, mutation: Mutations::Update::ModifyComment, description: "Update Comment"
    field :update_like, mutation: Mutations::Update::ModifyLike, description: "Update Like"
    field :update_follow, mutation: Mutations::Update::ModifyFollow, description: "Update Follow"

    ## Destroy MUTATION
    field :destroy_user, mutation: Mutations::Destroy::RemoveUser, description: "Destroy User"
    field :destroy_post, mutation: Mutations::Destroy::RemovePost, description: "Destroy Post"
    field :destroy_comment, mutation: Mutations::Destroy::RemoveComment, description: "Destroy Comment"
    field :destroy_like, mutation: Mutations::Destroy::RemoveLike, description: "Destroy Like"
    field :destroy_follow, mutation: Mutations::Destroy::RemoveFollow, description: "Destroy Follow"
  end
end
