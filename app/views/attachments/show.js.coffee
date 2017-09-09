$("#image-fullsize").html("<%= escape_javascript(render 'attachments/show') %>")
$("#image-fullsize").modal("show")
