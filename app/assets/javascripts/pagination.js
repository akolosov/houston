$(function () {
  $('.pagination a').bind("click", function () {
    $('.pagination').html('Загрузка страницы...');
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('#filter a').bind("click", function () {
    $.get(this.href, null, null, 'script');
    return false;
  });

});