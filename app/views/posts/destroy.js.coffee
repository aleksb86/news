jQuery ->
    $(document)
    .bind("ajax:beforeSend", (xhr, options) ->
      # handler("no msg", xhr, options)
      )
    .bind("ajax:complete", (xhr, status) ->
      # handler("no msg", xhr, status)
      )
    .bind("ajax:success", (response, status, xhr) ->
      handler(response, status, xhr)
      refresh
      )
    .bind("ajax:error", (response, status, xhr) ->
      handler(response, status, xhr)
      refresh
      )

handler = (msg, status, xhr) ->
  $(".posts-list").html(msg + "<br />" + status + "<br />" + xhr)
  # alert msg
  # console.log(msg)
  # console.log(status)
  # console.log(xhr)

refresh = ->
  $.ajax 'posts/index',
    type: 'GET'
    dataType: 'html'
    error: (jqXHR, textStatus, errorThrown) ->
        $('body').append "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
        $('body').append "Successful AJAX call: #{data}"

  # .html("<%= escape_javascript(render partial: "posts/index", locals: {"posts":{"title":"11", "text":"222"}}) %>")
  # console.log("refreshed")
