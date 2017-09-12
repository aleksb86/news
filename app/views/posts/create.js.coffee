# console.log("from create.js.coffee")

$("#posts-list").html("<%= escape_javascript(render 'posts') %>")
$("#post-modal").modal("hide")

# $("#post-modal").html("<%= escape_javascript(render 'form') %>")
# $("#post-modal").modal("show")

# $("#post-alert").addClass("alert-success")
# $("#post-alert").append("<%= escape_javascript(flash[:notice]) %>")
# $("#post-alert").alert()
# $("#posts-list").html("<%= escape_javascript(render 'posts') %>")
