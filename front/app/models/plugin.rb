class Plugin < ActiveRecord::Base
  has_and_belongs_to_many :plugin_combinations
  attr_accessible :description, :name, :path

  attr_accessible :plugin_combination_ids
end
