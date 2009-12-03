class Deliverable < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :type
end
