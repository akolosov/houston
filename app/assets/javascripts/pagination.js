$(function () {
  bind_ajax();

  $('#filter a').bind("click", function () {
    $.get(this.href, null, null, 'script');
    return false;
  });

});