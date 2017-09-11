class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    elsif user.writer?
      can [:create, :update], Post
      can [:create, :destroy, :update], Attachment
    else
      can :read, [Post, Attachment]
    end
  end
end
