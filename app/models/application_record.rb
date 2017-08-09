class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.first(*args)
    order(created_at: :asc).first(*args)
  end

  def self.last(*args)
    order(created_at: :desc).first(*args)
  end
end
