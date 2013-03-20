# Moka is responsible for launching the scripts for each controller/action.
namespace 'HEIConnect.Helpers'
  Moka:
    exec: (controller, action = 'init') ->
      ns = (namespace 'HEIConnect.Pages')
      ns[controller][action]()  if controller isnt '' and ns[controller] and typeof ns[controller][action] is 'function'

    miaou: ->
      body = document.body
      controller = body.getAttribute('data-controller')
      action = body.getAttribute('data-action')

      HEIConnect.Helpers.Moka.exec 'common'
      HEIConnect.Helpers.Moka.exec controller
      HEIConnect.Helpers.Moka.exec controller, action