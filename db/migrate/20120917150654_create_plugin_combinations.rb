class CreatePluginCombinations < ActiveRecord::Migration
  def change
    create_table :plugin_combinations do |t|
      t.references 	:company, :null => false
      t.string 		:name, :null => false
      t.text    	:thumbnail_collector
      t.text		  :content_analyzer
      t.timestamps
    end
    add_index :plugin_combinations, :company_id
  end
end
