// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require mousetrap
//= require markitup
//= require twitter/bootstrap
//= require_tree .

markdownSettings = {
    nameSpace: 'markdown', // Useful to prevent multi-instances CSS conflict
    onShiftEnter: {keepDefault: false, openWith: '\n\n'},
    markupSet: [
        {name: 'First Level Heading', key: "1", placeHolder: 'Your title here...', closeWith: function (markItUp) {
            return miu.markdownTitle(markItUp, '=')
        } },
        {name: 'Second Level Heading', key: "2", placeHolder: 'Your title here...', closeWith: function (markItUp) {
            return miu.markdownTitle(markItUp, '-')
        } },
        {name: 'Heading 3', key: "3", openWith: '### ', placeHolder: 'Your title here...' },
        {name: 'Heading 4', key: "4", openWith: '#### ', placeHolder: 'Your title here...' },
        {name: 'Heading 5', key: "5", openWith: '##### ', placeHolder: 'Your title here...' },
        {name: 'Heading 6', key: "6", openWith: '###### ', placeHolder: 'Your title here...' },
        {separator: '---------------' },
        {name: 'Bold', key: "B", openWith: '**', closeWith: '**'},
        {name: 'Italic', key: "I", openWith: '_', closeWith: '_'},
        {separator: '---------------' },
        {name: 'Bulleted List', openWith: '- ' },
        {name: 'Numeric List', openWith: function (markItUp) {
            return markItUp.line + '. ';
        }},
        {separator: '---------------' },
        {name: 'Picture', key: "P", replaceWith: '![[![Alternative text]!]]([![Url:!:http://]!] "[![Title]!]")'},
        {name: 'Link', key: "L", openWith: '[', closeWith: ']([![Url:!:http://]!] "[![Title]!]")', placeHolder: 'Your text to link here...' },
        {separator: '---------------'},
        {name: 'Quotes', openWith: '> '},
        {name: 'Code Block / Code', openWith: '(!(\t|!|`)!)', closeWith: '(!(`)!)'}
    ]
};

// mIu nameSpace to avoid conflict.
miu = {
    markdownTitle: function (markItUp, char) {
        heading = '';
        n = $.trim(markItUp.selection || markItUp.placeHolder).length;
        for (i = 0; i < n; i++) {
            heading += char;
        }
        return '\n' + heading + '\n';
    }
};

$('#form').keypress(function(e){
    if (((e.keyCode == 13) || (e.keyCode == 10)) && (e.ctrlKey == true)) {
        this.submit();
    }
});

$('#form').keyup(function(e) {
    if (e.keyCode == 27) {
        if (confirm('Вы точно уверены?'))
            history.back();
    }
});

function bind_ajax() {
  $(".pagination a").each(function () {
    $(this).attr("data-remote", true);
  });

  $('.pagination a').bind("click", function () {
    $('.pagination').html('Загрузка страницы...');
    $.get(this.href, null, null, 'script');
    return false;
  });
};