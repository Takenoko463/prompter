# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
themes = [
  { name: "文学と創作" },
  { name: "技術とプログラミング" },
  { name: "ビジネスと経済" },
  { name: "アートとデザイン" },
  { name: "エンターテインメント" },
  { name: "健康とフィットネス" },
  { name: "科学と自然"},
  { name: "インタビュー質問"},
  {name: "その他"}
]
writing,programming,business,art,entertainment,fitness,science,interview=Category.create(themes)

writing_children=[{name: "小説"},{name: "詩"},{name: "キャラクター開発"}]
writing.children.create(writing_children)

programming_children=[{name: "Web開発"},{name: "モバイル開発"},{name: "データサイエンス"},{name: "DX"},{name: "プログラミン学習"}]
programming.children.create(programming_children)