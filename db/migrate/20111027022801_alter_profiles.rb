class AlterProfiles < ActiveRecord::Migration
  def change
      add_column :profiles, :about_me, :text
      add_column :profiles, :parish, :string
      add_column :profiles, :industry_specialty, :string
      add_column :profiles, :mentor, :int
      add_column :profiles, :chapter, :string
    end
end
