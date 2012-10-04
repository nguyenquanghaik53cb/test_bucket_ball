class ParticularEvent < ActiveRecord::Base
  belongs_to :url_matche

  attr_accessible :content, :name, :comapny_id
end
