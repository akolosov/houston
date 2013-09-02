# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http:#example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require mousetrap
#= require markitup
#= require twitter/bootstrap
#= require bootstrap-datepicker
#= require_tree .

$("#form").keypress (e) ->
  @submit()  if ((e.keyCode is 13) or (e.keyCode is 10)) and (e.ctrlKey is true)

$("#form").keyup (e) ->
  history.back()  if confirm("Вы точно уверены?")  if e.keyCode is 27

$ ->
  $(".pagination a").each ->
    $(this).attr "data-remote", true

  $(".pagination a").bind "click", ->
    $(".pagination").html "Загрузка страницы..."
    $.get @href, null, null, "script"
    false

  $("#filter a").bind "click", ->
    $.get @href, null, null, "script"
    false

