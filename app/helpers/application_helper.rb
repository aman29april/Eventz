module ApplicationHelper

  # def flash_div(*keys)
  #   visual_effect(:fade, :flashdiv)
  #   keys.collect { |key| content_tag(:div, flash[key], :class =>
  #     "flash #{key}") if flash[key] }.join
  # end

  def user_avatar(name)
    render partial: 'users/avatar', locals: LetterAvatarUtil.generate(name)
  end

end
