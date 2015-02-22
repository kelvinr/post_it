module ApplicationHelper

  def page_title(title = '')
    base_title = 'PostiT'
    title.empty? ? base_title : "#{title} | #{base_title}"
  end

  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end

  def display_time(time)
    time_ago_in_words(time) unless time.nil?
  end
end
