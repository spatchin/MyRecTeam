class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    true
  end

  def show?
    @current_user.try(:admin?) || (@current_user == @user)
  end

  def edit?
    @current_user.try(:admin?)
  end

  def update?
    @current_user.try(:admin?) || (@current_user == @user)
  end

  def destroy?
    @current_user.try(:admin?) && (@current_user != @user)
  end

  def profile?
    true
  end
end
