class FactoryPolicy < ApplicationPolicy
  def admin?
    return true if user.admin?
  end

  def view?
    true
  end

  class Scope < Scope
    def resolve
      return scope.all if user.admin?
    end
  end
end
