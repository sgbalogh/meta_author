module UsersHelper

  def is_admin?(user)
    if logged_in?
      user.access_level == 1
    end
  end
end
