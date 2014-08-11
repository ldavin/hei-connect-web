###

  JQuery
  = require jquery
  = require jquery_ujs

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
