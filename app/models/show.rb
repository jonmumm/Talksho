class Show < ActiveRecord::Base
  validates :name, :presence => true
end
