module ApplicationHelper
  # user letter avatar, Generates avatar with first letter of name
  def user_avatar(name)
    render partial: 'users/avatar', locals: LetterAvatarUtil.generate(name)
  end
end
