# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http:#example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery_ujs
#= require jquery.ui.sortable
#= require jquery.ui.nestedSortable
#= require jquery-migrate
#= require jquery.cookie
#= require mousetrap
#= require markitup
#= require twitter/bootstrap
#= require chosen-jquery
#= require scaffold
#= require sortable_tree/initializer
#= require expandable_tree/restorable
#= require expandable_tree/hashchange
#= require expandable_tree/initializer
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
