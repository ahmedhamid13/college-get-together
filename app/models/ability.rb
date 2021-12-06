# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user&.is_super_admin
      can :manage, :all

      can :manage, [Ahoy, User, Post, Comment, Like, Follow]
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :dashboard         # allow access to dashboard
      can :read, :all

      cannot :create, User, is_super_admin: true
      cannot :destroy, User, id: User.find_by(is_super_admin: true)&.id
    elsif user&.role_is?("admin")
      cannot :manage, :all

      can :manage, [Ahoy, User, Post, Comment, Like, Follow]
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :dashboard         # allow access to dashboard
      can :read, :all

      cannot :manage, User, id: User.find_by(is_super_admin: true)&.id
      cannot :create, User, is_super_admin: true
    elsif user&.role_is?("premium")
      cannot :manage, :all

      can :manage, User, id: user.id
      can :manage, [Post, Comment, Like, Follow], user: user
      can :create, [Post, Comment, Like, Follow]
      can :read, :all

      cannot :manage, :dashboard         # allow access to dashboard
      cannot :access, :rails_admin
      cannot :create, User, is_super_admin: true
    elsif user&.role_is?("normal")
      cannot :manage, :all

      can :manage, User, id: user.id
      can :manage, [Post, Comment, Like, Follow], user: user
      can :create, [Post, Follow]
      can :read, :all

      cannot :create, [Comment, Like]
      can :create, [Comment, Like], user: { followers: { user_id: user.id } }

      cannot :manage, :dashboard         # allow access to dashboard
      cannot :access, :rails_admin
      cannot :destroy, [Post, Comment]
      cannot :create, User, is_super_admin: true
    else
      cannot :manage, :all

      can :read, :all
      cannot :manage, :dashboard         # allow access to dashboard
      cannot :access, :rails_admin
      cannot :create, User, is_super_admin: true
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
