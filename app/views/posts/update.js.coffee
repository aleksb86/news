$("#posts-list").html("<%= escape_javascript(render 'posts') %>")
$("#post-modal").modal('hide')
# TODO: try to update only changed post
