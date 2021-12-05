# frozen_string_literal: true

module Types::Inputs
  class PostInputType < Types::BaseInputObject
    argument :title, String, required: true
    argument :body, String, required: false
    argument :user_id, ID, required: true
  end
end
