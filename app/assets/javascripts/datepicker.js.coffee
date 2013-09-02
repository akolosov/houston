$ ->
  $("input.datetime").each (i) ->
    $(this).datepicker
      format: "dd.mm.yyyy 23:59"
      language: 'ru'
      clearBtn: true
      todayBtn: true