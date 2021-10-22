module ApplicationHelper

  def user_name(user)
    if user&.name.present?
      user.name
    else
      user&.email
    end
  end

  def submit_text
    if controller.action_name == 'new'
      '登録'
    elsif controller.action_name == 'edit'
      '更新'
    end
  end

  # デバイスのエラーメッセージ出力メソッド
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    # エラーメッセージ用のHTMLを生成
    messages = resource.errors.full_messages.each do |msg|
      html += <<-EOF
        <div class="error_field alert alert-danger" role="alert">
          <p class="error_msg">#{msg}</p>
        </div>
      EOF
    end
    html.html_safe
  end
end
