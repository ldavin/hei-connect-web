
# JQuery
#= require jquery
#= require jquery_ujs

# For bootstrap theme related functionalitites (some sub-scrits could also be disabled!)
#= require bootstrap.min

# Charts drawing library
#= require raphael
#= require morris

# Lib for creating namespaces
#= require namespace

# App helpers
#= require_tree ./helpers

# App widgets
#= require_tree ./widgets

# Calendar drawing library
#= require jquery-ui
#= require fullcalendar/fullcalendar.js

# App pages specific scripts
#= require_tree ./pages

$ ->
  HEIConnect.Helpers.Moka.miaou()