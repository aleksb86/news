# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  closeModal = (id) ->
    $(id).modal("hide")

  refresh = (id, data) ->
    $(id).html(data)

  invokeAjax = (url, id) ->
    $.ajax url,
      type: 'GET'
      error: (response, status, xhr) ->
        console.log('ajax error')
        # refresh('#test', "error in AJAX")
      success: (data) ->
        console.log("ajax succeeded, data: #{data}")
        # refresh('#test', data)

  succeeded = (x, y='', z='', w='') ->
    console.log "response: #{x}, status: #{y}, xhr: #{z}, e: #{w}"

  $(document).on "click", "#button-post-save", ->
    console.log "event fired!"
    invokeAjax('/posts', '#test')

      # TODO: make request, close modal and refresh element

  $(document.body)
    .on "ajax:success", "#button-post-save", (response, status, xhr) ->
      # closeModal "#post-modal"
      # succeeded 'hi from #new_post..'
      # succeeded response, status, xhr
      refresh('#test', data)

  #
  #   .on "ajax:success", "#edit-post", (response, status, xhr) ->
  #     closeModal " "
  #     succeeded 'hi from #edit-post..'
  #     succeeded response, status, xhr
  #
  #   .on "ajax:success", ".delete-attachment", (response, status, xhr) ->
  #     succeeded 'hi from delete-attachment..'
  #     succeeded response, status, xhr

  # $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
  #   succeeded e, data, status, xhr

#     .bind "ajax:error", '#new_post', (response, status, xhr) ->
#       null
