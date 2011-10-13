class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :screen_name
      t.string :company
      t.string :title
      t.string :industry
      t.string :facebook_link
      t.string :linkedin_link
      t.string :twitter_link
      t.string :phone_number
      t.integer :display, :default => 0
      
      t.timestamps
    end
  end
end