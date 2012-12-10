$ ->
  # Modal form send button
  if $('#login_button').length
    $('#login_button').one 'click', ->
      $('#login_button').addClass('disabled')
      $('#login_form').submit()