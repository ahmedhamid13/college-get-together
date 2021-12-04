# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_presence_of :user, :post, :body
  validates :body, length: { minimum: 1, maximum: 3000 }

  rails_admin do
    object_label_method do
      :body
    end

    list do
      field :id
      field :body
      field :user
      field :post
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :body
      field :user
      field :post
      field :created_at
      field :updated_at
    end

    create do
      field :body
      field :user
      field :post
    end

    update do
      field :body
      field :user
      field :post
    end
  end
end
