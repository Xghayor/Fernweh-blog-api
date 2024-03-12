class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Post, Comment, Like]

    return unless user.present?
    can :profile, User, id: user.id
    can :add_image, User, id: user.id
    can :create, [Comment, Like]

    can :destroy, Comment, user: user.id
    can :destroy, Like, user: user.id

    if user.admin?
      can :manage, :all
    end
  end
end
