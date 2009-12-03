class Exercise < ActiveRecord::Base
  belongs_to :course
  has_many :deliverables
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :users
end
