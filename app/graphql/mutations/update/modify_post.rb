# frozen_string_literal: true

module Mutations::Update
  class ModifyPost < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Inputs::PostInputType, required: true
    field :post, Types::PostType, null: false

    def resolve(id:, params:)
      post_params = Hash params

      begin
        post = Post.find(id)
        post.update!(post_params)
        { post: post }
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new("Post does not exist.")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
