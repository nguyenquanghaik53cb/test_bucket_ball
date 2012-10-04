class VisitorServer < ActiveRecord::Base
  belongs_to :company
  attr_accessible :address, :location, :note, :password, :port
  
  def url
    if port
      "#{address}:#{port}"
    else
      "#{address}"
    end
    
  end
end
