# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    if user&.is_super_admin
      # can :manage, [Ahoy, User, Post, Comment, Like, Follow]
      # can [:access, :read, :create, :update, :export, :history], [Category]
      can :manage, [Ahoy, User, Post, Comment, Like, Follow]
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :dashboard         # allow access to dashboard
      can :read, :all
    elsif user&.role_is?("admin")
      can [:update, :destroy], [Ahoy, User, Post, Comment, Like, Follow], user: user
      can [:access, :create, :export, :history], [Ahoy, User, Post, Comment, Like, Follow]
      # can [:access, :read, :create, :update, :export, :history], [Category]
      can :read, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :dashboard         # allow access to dashboard
    elsif user&.role_is?("premium")
      can :manage, [User, Post, Comment, Like, Follow], user: user
      can :read, :all

      cannot :manage, :dashboard         # allow access to dashboard
      cannot :access, :rails_admin
      # can :manage, []
    elsif user&.role_is?("normal")
      can [:access, :create, :update, :export, :history], [User, Post, Comment, Like, Follow], user: user
      can :read, :all

      cannot :manage, :dashboard         # allow access to dashboard
      cannot :access, :rails_admin
      cannot :destroy, [User, Post, Comment, Like, Follow]
      # can :manage, []
    else
      can :read, :all
      cannot :access, :rails_admin
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
