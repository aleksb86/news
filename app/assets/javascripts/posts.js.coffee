# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
# TODO: 
  $(".alert-placeholder").fadeTo(2000, 500).slideUp 500, () ->
    $(".alert").slideUp(500)
