class PluginCombination < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :plugins
  attr_accessible :name, :thumbnail_collector,:content_analyzer


  attr_accessible :plugin_ids

end
