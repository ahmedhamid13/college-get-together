# frozen_string_literal: true

module Mutations::Destroy
  class RemoveComment < Mutations::BaseMutation
    argument :id, ID, required: true
    field :comment, Types::CommentType, null: false

    def resolve(id:)
      comment = Comment.find(id)
      comment.destroy
      { comment: comment }
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Comment does not exist.")
    end
  end
end
