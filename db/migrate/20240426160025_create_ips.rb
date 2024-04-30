class CreateIps < ActiveRecord::Migration[7.0]
  def change
    create_table :ips do |t|
      t.string :ip_md5_head8, null: false
      t.timestamps
    end
  end
end
