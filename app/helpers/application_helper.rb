module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.username
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end

  def self.search(search)
    all :conditions =>  (search ? { :tag_name => search.split} : [])
  end
end
