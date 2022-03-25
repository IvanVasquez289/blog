module ApplicationHelper
  def gravatar_for(user, options = {size:80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    tamano = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{tamano}"
    image_tag(gravatar_url, alt: user.username, class:"rounded mx-auto d-block shadow")
  end
end
