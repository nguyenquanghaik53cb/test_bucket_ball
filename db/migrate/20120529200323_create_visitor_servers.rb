class CreateVisitorServers < ActiveRecord::Migration
  def change
    create_table :visitor_servers do |t|
      t.string :address, :null => false
      t.integer :port
      t.references :company
      t.string :password
      t.string :location
      t.string :note

      t.timestamps
    end
    add_index :visitor_servers, :company_id
  end
end
