class CreateUrlMatches < ActiveRecord::Migration
  def change
    create_table :url_matches do |t|
      t.references :company, :null => false
      t.string  :match, :null => false
      t.string  :name,  :null => false
      t.boolean :untrack, :null => false, :default => false 

      t.timestamps
    end
    add_index :url_matches, :company_id
    add_index :url_matches, :name
  end
end
