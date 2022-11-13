module UserHelper
  def friending_button(user)
    button_to "Add Friend", friend_user_path, data: { turbo: false }
  end
end