$(function () {
  $('.pagination a').live("click", function () {
    $('.pagination').html('Загрузка страницы...');
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('#filter a').live("click", function () {
    $.get(this.href, null, null, 'script');
    return false;
  });

});