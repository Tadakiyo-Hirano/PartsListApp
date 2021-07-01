module UsersHelper

  def user_current_sign_in_at(user)
    user.current_sign_in_at.strftime("%Y/%m/%d %H:%M") unless user.current_sign_in_at == nil
  end

  def  user_last_sign_in_at(user)
    user.last_sign_in_at.strftime("%Y/%m/%d %H:%M") unless user.current_sign_in_at == nil
  end
end
