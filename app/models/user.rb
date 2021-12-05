# frozen_string_literal: true

class User < ApplicationRecord
  # default_scope { where(is_super_admin: false) }
  has_many :posts, class_name: "Post", foreign_key: "user_id", dependent: :destroy
  has_many :comments, class_name: "Comment", foreign_key: "user_id", dependent: :destroy
  has_many :likes, class_name: "Like", foreign_key: "user_id", dependent: :destroy
  has_many :follows, class_name: "Follow", foreign_key: "user_id", dependent: :destroy
  has_many :followers, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :email, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email, :password, :user_role, presence: true, on: :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, length: { maximum: 250 }, if: -> { email.present? }
  validates :name, length: { minimum: 1, maximum: 250 }, if: -> { name.present? }

  enum user_role: [:normal, :premium, :admin], _default: "normal"
  validates :user_role, inclusion: { in: %w{normal premium admin} }

  attr_accessor :premium

  validate :only_one_super_admin

  def only_one_super_admin
    super_admin = User.where(is_super_admin: true)
    if super_admin.size == 1 && self.is_super_admin && self.id != super_admin.first.id
      errors.add(:is_super_admin, "Only one super admin is allowed")
    end
  end

  before_destroy do
    raise "Destroy aborted; you can't do that!" if self.is_super_admin
  end

  before_save :set_premium_role, if: Proc.new { self.premium }

  def set_premium_role
    self.user_role = :premium
  end

  before_save :set_default_name, if: Proc.new { self.name.blank? }

  def set_default_name
    self.name = self.email
  end

  before_save :set_default_role_super_admin, if: Proc.new { self.is_super_admin }

  def set_default_role_super_admin
    self.user_role = :admin
  end

  def role_is?(role)
    self.id && self.user_role == role.to_s
  end

  rails_admin do
    object_label_method do
      :email
    end

    list do
      field :id
      field :email
      field :user_role
      field :image
      field :active
      field :deleted_at
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :email
      field :user_role
      field :image
      field :posts
      field :comments
      field :active
      field :deleted_at
      field :created_at
      field :updated_at
    end

    create do
      field :email
      field :password
      field :user_role
      field :image
      field :active
    end

    update do
      field :email
      field :password
      field :user_role
      field :image
      field :active
    end
  end
end
