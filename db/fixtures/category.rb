#CSVファイルの読み込みを有効化
require "csv"

##CSVファイルをforeachでインポート
CSV.foreach('db/category.csv') do |row|
  Category.seed(:id => row[0], :name => row[1], :ancestry => row[2])
end 