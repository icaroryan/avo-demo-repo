class Workspace < ApplicationRecord
  belongs_to :organization, optional: true

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, inverse_of: :workspaces

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name organization_id created_at updated_at]
  end
end
