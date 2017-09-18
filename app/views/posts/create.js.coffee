$("#post-modal").modal('hide')

if $("#show-single-post").children().length
  $("#show-single-post").html("<%= escape_javascript(render 'post_single') %>")
else
  $("#posts-list").prepend("<div id=<%= @post.id %>><%= escape_javascript(render 'post_preview') %></div>")

$(".alert-placeholder").html("<%= escape_javascript(alert) %>")
