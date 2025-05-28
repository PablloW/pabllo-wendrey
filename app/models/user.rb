class User < ApplicationRecord
  belongs_to :company

  scope :by_company, -> (identifier) { 
    joins(:company).where(companies: { identifier: identifier }) if identifier.present?
  }
  scope :by_username, -> (username) {
    where('username ILIKE ?', "%#{sanitize_sql_like(username)}%") if username.present?
  }
end
