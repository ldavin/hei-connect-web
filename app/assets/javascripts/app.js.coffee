###
  Scripts preceded by "--" are not required since not used

  JQuery
  = require jquery
  = require jquery_ujs

  For bootstrap theme related functionalitites (some sub-scrits could also be disabled!)
  = require bootstrap.min

  Charts drawing library
  = require raphael
  = require morris

  Calendar drawing library
  = require jquery-ui

  Lib for creating namespaces
  = require namespace

  App helpers
  = require_tree ./helpers

  App widgets
  = require_tree ./widgets

  App pages specific scripts
  = require_tree ./pages

###

# Launch scripts for the current page
$ ->
  HEIConnect.Helpers.Moka.miaou()