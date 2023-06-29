class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'admin'
      can :delete, Post
      can :destroy, Post
      can :destroy, Comment
      can :delete, Comment
    else
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
      can :delete, Post, author_id: user.id
      can :delete, Comment, user_id: user.id
    end
  end
end
