# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, -> { where("requester_id = ? OR requested_id = ? AND status = ?", self.id, self.id, Friendship.statuses[:accepted]) }

  has_many :requested_friendships, class_name: "Friendship", foreign_key: "requester_id"
  has_many :friendship_requests, class_name: "Friendship", foreign_key: "requested_id"
  
  def request_friendship(user)
    requested_friendships.create(requested_id: user.id)
  end
end
