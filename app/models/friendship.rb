# == Schema Information
#
# Table name: friendships
#
#  id           :bigint           not null, primary key
#  requester_id :integer
#  requested_id :integer
#  status       :integer          default("requested")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Friendship < ApplicationRecord
  enum status: { requested: 0, accepted: 1, rejected: 2 }

  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
end
