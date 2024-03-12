# frozen_string_literal: true

class User < ApplicationRecord
  enum ban_status: { not_banned: 0, banned: 1 }

  validates :idfa, presence: true, uniqueness: true,
                   format: { with: /\A[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\z/i,
                             message: 'Not a valid UUID' }
  validates :ban_status, presence: true

  has_many :integrity_logs, foreign_key: :idfa, primary_key: :idfa, dependent: :destroy, inverse_of: :user

  scope :banned, -> { where(ban_status: User.ban_statuses[:banned]) }
  scope :not_banned, -> { where(ban_status: User.ban_statuses[:not_banned]) }
end
