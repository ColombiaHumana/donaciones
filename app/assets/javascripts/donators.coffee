# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.slider').on 'moved.zf.slider', ->
    $('#amount_holder').html "$ "+$(this).children('.slider-handle').attr('aria-valuenow')
