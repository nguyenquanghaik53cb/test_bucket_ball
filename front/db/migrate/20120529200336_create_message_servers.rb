class CreateMessageServers < ActiveRecord::Migration
  def change
    create_table :message_servers do |t|
      t.string :address, :null => false
      t.integer :port
      t.references :company
      t.string :password
      t.string :location
      t.string :note

      t.timestamps
    end
    add_index :message_servers, :company_id
  end
end
