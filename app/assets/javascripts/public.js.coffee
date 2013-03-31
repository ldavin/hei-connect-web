###

  JQuery
  = require jquery
  = require jquery_ujs

  For bootstrap theme related functionalitites (some sub-scrits could also be disabled!)
  = require bootstrap

  Fix for placeholders on old (ie only?) browsers
  = require ie_placeholder_fix

  Lib for creating namespaces
  = require namespace

  App helpers
  = require_tree ./helpers

  App widgets
  = require_tree ./widgets

  App pages specific scripts
  = require_tree ./pages

  = require_self
###

# Launch scripts for the current page
$ ->
  HEIConnect.Helpers.Moka.miaou()
