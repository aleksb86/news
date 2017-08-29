$("#post-modal").html("<%= escape_javascript(render 'form_edit') %>")
$("#post-modal").modal("show")
