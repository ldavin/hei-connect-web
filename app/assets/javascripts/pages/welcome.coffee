(namespace 'HEIConnect.Pages').welcome =
  init: ->

  status: ->
    # On page resize
    $(window).resize ->
      $("iframe").each ->
        $(this).width $(this).parent().width()

    # On page load
    $("iframe").each ->
      $(this).width $(this).parent().width()
