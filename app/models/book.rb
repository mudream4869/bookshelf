class Book < ActiveRecord::Base
  validates_presence_of :sitename
  validates_presence_of :spoturl
  validates_uniqueness_of :spoturl
  validates_uniqueness_of :title
end
