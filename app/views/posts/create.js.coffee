$("#post-modal").modal('hide')

if $("#show-single-post").children().length
  $("#show-single-post").html("<%= escape_javascript(render 'post_single') %>")
else
  # $("#posts-list").prepend("<%= escape_javascript(render 'post_preview') %>")
  $("#posts-list").prepend("<div id=<%= @post.id %>> \
    <%= escape_javascript(render 'post_preview') %> \
    </div>")
