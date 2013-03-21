###
  Scripts preceded by "--" are not required since not used

  JQuery
  = require jquery
  = require jquery_ujs

  For bootstrap theme related functionalitites (some sub-scrits could also be disabled!)
  = require bootstrap

  For inline charts or pies (http://benpickles.github.com/peity/)
  -- require jquery.piety

  For radio, checkboxes, and file inputs styling (re-activate if used in views!)
  -- require jquery.browser
  -- require jquery.uniform

  Dials (circle stats)
  -- require jquery.knob

  For select inputs styling (re-activate if used in views!)
  -- require chosen.jquery

  Plot drawing library
  -- require flot/jquery.flot
  -- require flot/jquery.flot.resize
  -- require flot/jquery.flot.pie

  Gauge drawing library
  -- require justgage/raphael.2.1.0.min
  -- require justgage/justgage

  Calendar drawing library
  = require jquery-ui
  = require fullcalendar

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