$("#posts-list").empty()
$("#single-post").html("<%= escape_javascript(render 'show') %>")
$("#pagination").hide()
