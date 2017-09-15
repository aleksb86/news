$("p#<%= @attachment.id %>").remove()
$(".col-md-4#<%= @attachment.id %>").remove()
unless $("#attachments-list").children().length
  $("#<%= @attachment.post_id %> .img-responsive").attr("src", "/attachments/noimage")
