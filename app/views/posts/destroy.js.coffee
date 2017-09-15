if $("#posts-list").children().length > 1
  $("#<%= @post.id %>").remove()
else
  window.location.reload()
