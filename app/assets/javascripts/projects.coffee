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
  $('form').on 'keypress', ':input:not(textarea,project_address)', (event) ->
    if event.keyCode == 13
      event.preventDefault()
    return
  $('#project_address').on 'change', ->
    address = $(this).val().replace(RegExp(' ', 'g'), '+')
    $('#map_image').attr 'src', 'https://maps.googleapis.com/maps/api/staticmap?center=' + address + '&zoom=14&size=500x300&markers=' + address + '&sensor=false'
    return
  $('#show_more_link').click ->
    total_size = $('.pilot-list').size()
    show_size = $('.pilot-list:visible').size() + parseInt($('#current_pilots_size').text())
    if show_size > total_size
      show_size = total_size
    $('.pilot-list:lt('+ show_size + ')').show()
    $('.showing-text').text("Showing " + show_size + " of " + total_size + " available pilots ")
    if show_size >= total_size
      $('#show_more_link').remove()
    return