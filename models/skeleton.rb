# sample Model model with a validation
# hook is set in the corresponding route for saving a model
class Skeleton < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
end
