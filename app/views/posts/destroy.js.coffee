$("#posts-list").html("<%= escape_javascript(render 'posts') %>")
$("#pagination").empty()
$("#pagination").html("<%= will_paginate @posts, renderer: BootstrapPagination::Rails, previous_label: '<', next_label: '>' %>")
