module PostsHelper
  def alert
    if flash.any?
      html = flash.map do |k, v|
        unless [:danger, :success].include?(k)
          k = 'info'
        end
        content_tag(:div, 'jab', class: "alert alert-#{k} alert-dismissable") do
          concat content_tag(:a, '&times;'.html_safe, class: 'close',
            'href' => '#', 'data-dismiss' => 'alert', 'aria-label' => 'close')
          concat v
        end
      end
      html.join().html_safe
    end
  end
end
