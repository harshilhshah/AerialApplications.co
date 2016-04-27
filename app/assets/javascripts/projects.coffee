# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('td').on 'click', ->
    $('.clicked').removeClass('clicked')
    $(this).addClass('clicked')
    num = $(this).text()
    $('#due_day:hidden').val(num)
    return