$("#post-modal").html("<%= escape_javascript(render 'form') %>")
$("#post-modal").modal("show")
