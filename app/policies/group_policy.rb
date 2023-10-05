class GroupPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.joins(:subscriptions).where(subscriptions: { user: user })
    end
  end
end
