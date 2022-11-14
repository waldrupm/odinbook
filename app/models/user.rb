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

  has_many :outgoing_friend_requests, -> { where('Friendships.status = ?', 0) }, class_name: "Friendship", foreign_key: "requester_id"
  has_many :incoming_friend_requests,-> { where('Friendships.status = ?', 0) }, class_name: "Friendship", foreign_key: "requested_id"

  has_many :requested_friends, through: :outgoing_friend_requests, source: :requested
  has_many :requesting_friends, through: :incoming_friend_requests, source: :requester

  has_many :accepted_friends, ->(user) { unscope(:where).where('Friendships.status = ? AND (Friendships.requester_id = ? OR Friendships.requested_id = ?)', 1, user.id, user.id) }, class_name: "Friendship"

  def friends
    Friendship.where('Friendships.status = ? AND (Friendships.requester_id = ? OR Friendships.requsted_id = ?', 1, user.id, user.id)
  end

  def request_friendship(user)
    Friendship.create(requester: self, requested: user)
  end

  def accept_friendship(user)
    friendship = Friendship.find_by(requester: user, requested: self)
    friendship.status = 1
    friendship.save
  end
end
