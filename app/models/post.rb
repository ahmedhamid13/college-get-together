# frozen_string_literal: true

class Post < ApplicationRecord
  visitable :ahoy_visit

  belongs_to :user
  validates_presence_of :user, :title
  validates :title, length: { minimum: 1, maximum: 100 }
  validates :body, length: { minimum: 1, maximum: 3000 }

  has_many :comments, class_name: "Comment", foreign_key: "post_id"
  has_many :likes, class_name: "Like", foreign_key: "post_id"

  rails_admin do
    object_label_method do
      :title
    end

    list do
      field :id
      field :title
      field :body
      field :user
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :title
      field :body
      field :user
      field :comments
      field :likes
      field :created_at
      field :updated_at
    end

    create do
      field :title
      field :body
      field :user
    end

    update do
      field :title
      field :body
      field :user
    end
  end
end
