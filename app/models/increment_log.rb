class IncrementLog < ApplicationRecord
  belongs_to :user

  def self.selectLast(user_id)
    self.select(:id, :number, :created_at).order(:created_at).where(user_id: user_id).last
  end
end
