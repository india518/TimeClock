# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require jquery
//= require jquery_ujs
//= require bootstrap
$(document).ready ->
  $("#new_user").on("ajax:success", (e, data, status, xhr) ->
    $("#new_post").append "<p>success</p>"
  ).bind "ajax:error", (e, xhr, status, error) ->
    $("#new_user").append "<p>ERROR</p>"