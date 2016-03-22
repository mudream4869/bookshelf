class Book < ActiveRecord::Base
  validates_presence_of :sitename
  validates_presence_of :spoturl
end
