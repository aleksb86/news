$("#post-modal").html("<%= escape_javascript(render 'results') %>")
$("#post-modal").modal("show")
