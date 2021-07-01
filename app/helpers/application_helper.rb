module ApplicationHelper

  def user_name(user)
    if user&.name.present?
      user.name
    else
      user&.email
    end
  end
end
