class Vehicle < ApplicationRecord
  self.inheritance_column = :type

  validates :type, presence: true

  belongs_to :owner

  def self.find_sti_class(type_name)
    super("Vehicles::#{type_name.camelize}")
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "owner_id", "type", "updated_at"]
  end
end
