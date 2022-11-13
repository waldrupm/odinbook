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
FactoryBot.define do
  factory :friendship do
    requester_id { 1 }
    requested_id { 1 }
    status { 1 }
  end
end
