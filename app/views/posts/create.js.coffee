$("#posts-list").html("<%= escape_javascript(render 'posts') %>")
$("#post-modal").modal('hide')
$("#single-post").empty()
