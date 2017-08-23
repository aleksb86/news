# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # preventEnterOnField = (e) ->
  #   if e.keyCode == 13
  #     console.log "Enter pressed!"
  #     false

  closeModal = (id) ->
    $(id).modal("hide")

#   # beforeSend = ->
#   #   console.log 'text from my posts.beforeSend'
#   #
#   # complete = ->
#   #   console.log 'text from my posts.complete'
#   #
#   # success = ->
#   #   console.log 'text from my posts.succes'
#   #
#   # error = ->
#   #   console.log 'text from my posts.error'
#
  $("#post-modal")
    # .bind "ajax:beforeSend", '#new_post', null
    # .bind "ajax:complete", '#new_post', (xhr, status) ->
    #   null
    .bind "ajax:success", (response, status, xhr) ->
      closeModal("#post-modal")
#     .bind "ajax:error", '#new_post', (response, status, xhr) ->
#       null
