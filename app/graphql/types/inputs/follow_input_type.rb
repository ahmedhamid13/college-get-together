# frozen_string_literal: true

module Types::Inputs
  class FollowInputType < Types::BaseInputObject
    argument :user_id, ID, required: true
    argument :followed_id, ID, required: true
  end
end
