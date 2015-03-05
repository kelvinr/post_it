module ApplicationHelper

  def page_title(title = '')
    base_title = 'PostiT'
    title.empty? ? base_title : strip_tags("#{title} | #{base_title}").sub(/All posts »/, "")
  end

  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end
end
