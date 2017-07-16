class Board < ActiveRecord::Base
  has_many :tasks, dependent: :destroy # not to leave all its tasks hanging
end
