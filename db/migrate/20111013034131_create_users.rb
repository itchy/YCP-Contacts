class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      t.integer :active, :default => 0
      t.date :active_until
      t.string :email
      t.string :roles, :default => "1"

      t.timestamps
    end
  end
end
