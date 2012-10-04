class CreateParticularEvents < ActiveRecord::Migration
  def change
    create_table :particular_events do |t|
      t.string :name, :null => false
      t.text   :content, :null => false
      t.references :url_match, :null => false

      t.timestamps
    end
    add_index :particular_events, :url_match_id
  end
end
