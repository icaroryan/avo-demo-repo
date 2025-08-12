class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :type
      t.timestamps
    end

    add_index :users, :type
  end
end
