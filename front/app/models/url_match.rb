class UrlMatch < ActiveRecord::Base
  belongs_to :company
  has_many :particular_events

  attr_accessible :match, :name, :untrack

  accepts_nested_attributes_for :particular_events, :allow_destroy => true
  attr_accessible :particular_events_attributes, :allow_destroy => true
  attr_accessible :particular_event_ids

end
