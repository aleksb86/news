# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  closeModal = (id) ->
    $(id).modal("hide")

  succeeded = (x, y='', z='', w='') ->
    console.log "response: #{x}, status: #{y}, xhr: #{z}, e: #{w}"

  $(document.body)
    # .bind "ajax:beforeSend", '#new_post', null
    # .bind "ajax:complete", '#new_post', (xhr, status) ->
    #   null
    .on "ajax:success", "#new_post", (response, status, xhr) ->
      closeModal "#post-modal"
      succeeded 'hi from #new_post..'
      succeeded response, status, xhr

    .on "ajax:success", "#edit-post", (response, status, xhr) ->
      closeModal " "
      succeeded 'hi from #edit-post..'
      succeeded response, status, xhr

    .on "ajax:success", ".delete-attachment", (response, status, xhr) ->
      succeeded 'hi from delete-attachment..'
      succeeded response, status, xhr

  # $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
  #   succeeded e, data, status, xhr

#     .bind "ajax:error", '#new_post', (response, status, xhr) ->
#       null

  # $(document.body)
  #   .on "ajax:success", ".delete-attachment", (response, status, xhr) ->
  #     succeeded 'hi from body..'
  #     succeeded response, status, xhr
