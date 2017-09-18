updated_element = $("#<%= @post.id %>")
updated_element.empty()
$("#post-modal").modal('hide')

if $("#show-single-post").children().length
  $("#show-single-post").html("<%= escape_javascript(render 'post_single') %>")
else
  updated_element.html("<%= escape_javascript(render 'post_preview') %>")

$(".alert-placeholder").html("<%= escape_javascript(alert) %>")
