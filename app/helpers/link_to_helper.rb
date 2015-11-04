module LinkToHelper

  def current_user_link_to(name, controller_name, action_name)
    if current_user
      link_to(name, controller_name, action_name)
    end
  end

end