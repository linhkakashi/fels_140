class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :avata
      t.string :email
      t.string :password_digest
      t.boolean :role

      t.timestamps null: false
    end
  end
end
