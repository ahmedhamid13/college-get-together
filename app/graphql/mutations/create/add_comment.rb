# frozen_string_literal: true

module Mutations::Create
  class AddComment < Mutations::BaseMutation
    argument :params, Types::Inputs::CommentInputType, required: true
    field :comment, Types::CommentType, null: false

    def resolve(params:)
      comment_params = Hash params

      begin
        comment = Comment.create!(comment_params)
        { comment: comment }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
