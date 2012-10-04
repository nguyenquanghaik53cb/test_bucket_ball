class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name,   :null => false, :unique => true
      t.string :apikey, :null => false, :unique => true
      t.boolean :jquery,:null => false, :default => true 

      t.timestamps
    end
    add_index :companies, :apikey
  end
end
