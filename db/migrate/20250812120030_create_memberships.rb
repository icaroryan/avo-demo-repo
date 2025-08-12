class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true
      t.timestamps
    end

    add_index :memberships, [:user_id, :workspace_id], unique: true
  end
end
