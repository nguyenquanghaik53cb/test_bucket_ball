class CreatePlugins < ActiveRecord::Migration
  def change
    create_table :plugins do |t|
      t.string :name,:null => false, :unique => true
      t.string :path,:null => false
      t.text :description

      t.timestamps
    end
  end
end
