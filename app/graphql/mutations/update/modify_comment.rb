# frozen_string_literal: true

module Mutations::Update
  class ModifyComment < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Inputs::CommentInputType, required: true
    field :comment, Types::CommentType, null: false

    def resolve(id:, params:)
      comment_params = Hash params

      begin
        comment = Comment.find(id)
        comment.update!(comment_params)
        { comment: comment }
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new("Comment does not exist.")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:" \
        " #{e.record.errors.full_messages.join(", ")}")
      end
    end
  end
end
