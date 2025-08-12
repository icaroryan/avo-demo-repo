class Organization < ApplicationRecord
  has_many :workspaces, dependent: :nullify

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end
end
