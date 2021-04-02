module ProductsHelper
  def submit_text
    if controller.action_name == 'new'
      '登録'
    elsif controller.action_name == 'edit'
      '更新'
    end
  end
end
