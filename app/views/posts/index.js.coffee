$("#single-post").empty()
$("#posts-list").html("<%= escape_javascript(render partial: 'posts' ) %>")
