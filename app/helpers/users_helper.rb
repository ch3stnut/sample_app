module UsersHelper

  # Output for displaying an user's gravatar.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    gravatar_url << "?s=#{options[:size]}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
