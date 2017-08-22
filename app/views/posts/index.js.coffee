$("post-modal").modal("hide")
$("#posts-list").html("<%= escape_javascript(render partial: 'posts/index' ) %>")
