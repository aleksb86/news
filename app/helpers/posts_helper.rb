module PostsHelper
  def alert
    html = flash.map do |k, v|
      unless [:danger, :success].include?(k)
        alert_type = 'info'
      else
        alert_type = k
      end
      content_tag(:div, class: "alert alert-#{alert_type} alert-dismissable") do
        concat content_tag(:a, '&times;'.html_safe, :class => 'close',
          'href' => '#', 'data-dismiss' => 'alert', 'aria-label' => 'close')
        concat v
      end
    end
    html.join().html_safe
  end
end
