Item.create!([
  {name: "文字列入力", typ: 1, presence: false, only_integer: false, format_with: ""},
  {name: "数字", typ: 2, presence: true, only_integer: true, format_with: ""},
  {name: "日時", typ: 3, presence: true, only_integer: false, format_with: ""},
  {name: "アルファベットのみ", typ: 1, presence: true, only_integer: false, format_with: "\\A[a-zA-Z]+\\z"}
])
