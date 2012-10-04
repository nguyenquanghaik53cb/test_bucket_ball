class Company < ActiveRecord::Base

  has_one :operator_server
  has_many :users
  has_many :url_matches
  has_many :plugin_combinations

 
  attr_accessible :apikey, :name, :jquery

  before_create :create_apikey

  # Rails_Admin
  attr_accessible :operator_server_attributes
  attr_accessible :operator_server_id

  accepts_nested_attributes_for :users, :allow_destroy => true
  attr_accessible :users_attributes, :allow_destroy => true
  
  accepts_nested_attributes_for :url_matches, :allow_destroy => true
  attr_accessible :url_matches_attributes, :allow_destroy => true

  accepts_nested_attributes_for :plugin_combinations, :allow_destroy => true
  attr_accessible :plugin_combinations_attributes, :allow_destroy => true
  attr_accessible :plugin_combination_ids

  
  validates :name,   :presence => true,
                     :uniqueness => true,
                     :length => {:minimum => 5, :maximum => 254}
  
  validates :apikey, :presence => true,
                     :uniqueness => true,
                     :length => {:minimum => 5, :maximum => 254}

  def operator_server_id
    self.operator_server.try :id
  end

  def operator_server_id=(id)
    self.operator_server = OperatorServer.find_by_id(id)
  end

  def create_apikey
    begin
      key = SecureRandom.hex(5)
    end until Company.where(:apikey => key).first == nil
    self.apikey = key
  end
  
end
