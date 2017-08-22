jQuery ->
    $(document)
    .bind("ajax:beforeSend", (xhr, options) ->
      )
    .bind("ajax:complete", (xhr, status) ->
      )
    .bind("ajax:success", (response, status, xhr) ->
      handler(response, status, xhr)
      # refresh
      )
    .bind("ajax:error", (response, status, xhr) ->
      handler(response, status, xhr)
      # refresh
      )

handler = (msg, status, xhr) ->
  console.log(msg)
  console.log(status)
  console.log(xhr)

$("#posts-list").html("<%= escape_javascript(render 'posts/index') %>")
# refresh = ->
#   $.ajax 'posts/index',
#     type: 'GET'
#     dataType: 'html'
#     error: (jqXHR, textStatus, errorThrown) ->
#         $('body').append "AJAX Error: #{textStatus}"
#     success: (data, textStatus, jqXHR) ->
#         $('body').append "Successful AJAX call: #{data}"
