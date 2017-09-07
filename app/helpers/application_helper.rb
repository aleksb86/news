module ApplicationHelper

  def pages_links(all_count, limit, url)
    pages_count = all_count / limit
    pages_count += 1 if all_count % limit
    html = ['<ul class="pagination">']

    if params[:page].nil?
      current = 1
    else
      current = params[:page].to_i
    end

    html << 1.upto(pages_count).map do |p|
      if p == current
        "<li class=\"active\"><a href=\"#{url}?page=#{p}\">#{p}</a></li>"
      else
        "<li><a href=\"#{url}?page=#{p}\">#{p}</a></li>"
      end
    end
    html.push("</ul>").join.html_safe
  end
end
