# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $("div#sync_users").on 'click', (event) ->
    $("div#sync_users").append("<progress/>")

$(document).ready(ready)
$(document).on('page:load', ready)
