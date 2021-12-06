# frozen_string_literal: true

module Mutations::Destroy
  class RemoveLike < Mutations::BaseMutation
    argument :id, ID, required: true
    field :like, Types::LikeType, null: false

    def resolve(id:)
      like = Like.find(id)
      like.destroy
      { like: like }
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Like does not exist.")
    end
  end
end
