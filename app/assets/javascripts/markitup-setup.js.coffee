window.markdownSettings = {
  nameSpace: "markdown" # Useful to prevent multi-instances CSS conflict
  onShiftEnter:
    keepDefault: false
    openWith: "\n\n"

  markupSet: [
    { name: "Заголовок 1-го уровня"
    key: "1"
    placeHolder: "Название здесь..."
    closeWith: (markItUp) ->
      miu.markdownTitle markItUp, "="
    },
    { name: "Заголовок 2-го уровня"
    key: "2"
    placeHolder: "Название здесь..."
    closeWith: (markItUp) ->
      miu.markdownTitle markItUp, "-"
    },
    { name: "Заголовок 3-го уровня"
    key: "3"
    openWith: "### "
    placeHolder: "Название здесь..." },
    { name: "Заголовок 4-го уровня"
    key: "4"
    openWith: "#### "
    placeHolder: "Название здесь..." },
    { name: "Заголовок 5-го уровня"
    key: "5"
    openWith: "##### "
    placeHolder: "Название здесь..." },
    { name: "Заголовок 6-го уровня"
    key: "6"
    openWith: "###### "
    placeHolder: "Название здесь..." },
    { separator: "---------------" },
    { name: "Полужирный"
    key: "B"
    openWith: "**"
    closeWith: "**" },
    { name: "Наклонный"
    key: "I"
    openWith: "_"
    closeWith: "_" },
    { separator: "---------------" },
    { name: "Список"
    openWith: "- " },
    { name: "Нумерованный список"
    openWith: (markItUp) ->
      markItUp.line + ". "
    },
    { separator: "---------------" },
    { name: "Картинка"
    key: "P"
    replaceWith: "![[![Альтернативный текст]!]]([![Ссылка:!:http://]!] \"[![Название]!]\")" },
    { name: "Ссылка"
    key: "L"
    openWith: "["
    closeWith: "]([![Ссылка:!:http://]!] \"[![Название]!]\")"
    placeHolder: "Текст для ссылки..." },
    { separator: "---------------" },
    { name: "Цитата"
    openWith: "> " },
    { name: "Блок кода"
    openWith: "(!(\t|!|`)!)"
    closeWith: "(!(`)!)" }
  ]
}
# mIu nameSpace to avoid conflict.
window.miu = markdownTitle: (markItUp, char) ->
  heading = ""
  n = $.trim(markItUp.selection or markItUp.placeHolder).length
  i = 0
  while i < n
    heading += char
    i++
  "\n" + heading + "\n"
