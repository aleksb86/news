$("#posts-alert").empty()
$("#post-modal").html("<%= escape_javascript(render 'form') %>")
$("#post-modal").modal("show")

# $("#post-alert").addClass("alert-danger")
# $("#post-alert").append("<%= escape_javascript(flash[:notice]) %>")
# $("#post-alert").alert()
