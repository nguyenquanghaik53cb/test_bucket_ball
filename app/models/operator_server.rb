class OperatorServer < ActiveRecord::Base
  belongs_to :company
  attr_accessible :address, :location, :note, :password, :port
end
