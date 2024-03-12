class IntegrityLog < ApplicationRecord
  belongs_to :user, foreign_key: :idfa, primary_key: :idfa, inverse_of: :integrity_logs

  validates :idfa, :ban_status, presence: true
end
