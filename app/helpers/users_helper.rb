module UsersHelper

  def user_current_sign_in_at(user)
    user.current_sign_in_at.strftime("%Y/%m/%d %H:%M") unless user.current_sign_in_at == nil
  end

  def  user_last_sign_in_at(user)
    user.last_sign_in_at.strftime("%Y/%m/%d %H:%M") unless user.current_sign_in_at == nil
  end

  def  user_created_at(user)
    user.created_at.strftime("%Y/%m/%d") unless user.current_sign_in_at == nil
  end

  def  user_updated_at(user)
    user.updated_at.strftime("%Y/%m/%d") unless user.current_sign_in_at == nil
  end

  def account_level_color(account_level)
    case account_level
    when "3" then
      "bronze_color"
    when "4" then
      "silver_color"
    when "5" then
      "gold_color"
    end
  end
end
