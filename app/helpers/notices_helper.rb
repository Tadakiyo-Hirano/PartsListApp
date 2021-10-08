module NoticesHelper
  def posted_date
    Date.current if controller.action_name == "new"
  end

  def display_off_bg_color(notice)
    "bg-secondary" if notice.display == false
  end
end
