class User < ApplicationRecord
  belongs_to :company

  scope :by_company, -> (id) {
    where(company_id: id) if id.present?
  }

  scope :by_username, ->(username) {
    where('LOWER(username) LIKE ?', "%#{username.downcase}%") if username.present?
  }
end
