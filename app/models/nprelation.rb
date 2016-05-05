class Nprelation < ActiveRecord::Base
  belongs_to :nonprofit, class_name: "Nonprofit"
  belongs_to :user, class_name: "User"
  validates :user_id, presence: true
end
