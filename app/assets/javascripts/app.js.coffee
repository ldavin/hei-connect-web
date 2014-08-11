###
  Scripts preceded by "--" are not required since not used

  JQuery
  = require jquery
  = require jquery_ujs

  For bootstrap theme related functionalitites (some sub-scrits could also be disabled!)
  = require bootstrap.min

  = require_self
###

# Launch scripts for the current page
$ ->
  HEIConnect.Helpers.Moka.miaou()