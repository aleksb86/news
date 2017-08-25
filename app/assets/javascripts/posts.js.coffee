# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  closeModal = (id) ->
    $(id).modal("hide")

  succeeded = ->
    console.log 'ajax send!'

  $("#post-modal")
    # .bind "ajax:beforeSend", '#new_post', null
    # .bind "ajax:complete", '#new_post', (xhr, status) ->
    #   null
    .bind "ajax:success", (response, status, xhr) ->
      closeModal("#post-modal")
#     .bind "ajax:error", '#new_post', (response, status, xhr) ->
#       null
  # $("#attachments-list")
  #   # .bind "ajax:beforeSend", '#new_post', null
  #   # .bind "ajax:complete", '#new_post', (xhr, status) ->
  #   #   null
  #   .bind "ajax:success", (response, status, xhr) ->
  #     succeeded()
