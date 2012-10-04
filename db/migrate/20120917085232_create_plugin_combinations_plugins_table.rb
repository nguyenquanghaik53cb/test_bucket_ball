class CreatePluginCombinationsPluginsTable < ActiveRecord::Migration
  def up
    create_table :plugin_combinations_plugins, :id => false do |t|
      t.references :plugin_combination, :null => false
      t.references :plugin, :null => false
    end
    add_index :plugin_combinations_plugins, [:plugin_combination_id,:plugin_id],
      :unique => true,
      :name   => "habtm_plugins"
  end

  def down
    drop_table :plugin_combinations_plugins
  end
end
