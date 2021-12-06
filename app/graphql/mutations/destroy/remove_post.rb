# frozen_string_literal: true

module Mutations::Destroy
  class RemovePost < Mutations::BaseMutation
    argument :id, ID, required: true
    field :post, Types::PostType, null: false

    def resolve(id:)
      begin
        post = Post.find(id)
        post.destroy
        { post: post }
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new("Post does not exist.")
      end
    end
  end
end
