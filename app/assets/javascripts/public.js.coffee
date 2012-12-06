$ ->
  # Modal form send button
  if $('#login_button').length
    $('#login_button').one 'click', ->
      $('#login_form').hide()
      $('#login_bar').show()
      $('#login_button').addClass('disabled')
      $('#login_form').submit()

  # Sign in and sign up forms
  if $('#public_form').length
    $('#public_form').submit ->
      $(this).submit ->
        no
      $('.control-group').add('.btn').hide()
      $('#public_bar').show()