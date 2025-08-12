class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :workspaces, through: :memberships, inverse_of: :users

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name email type created_at updated_at]
  end
end
