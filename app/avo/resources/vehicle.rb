class Avo::Resources::Vehicle < Avo::BaseResource
  self.authorization_policy = VehiclePolicy
  # self.includes = []
  # self.attachments = []
  self.search = {
    query: -> { 
      query.ransack(
        id_eq: params[:q],
        owner_name_cont: params[:q],
        m: "or"
      ).result(distinct: false)
    }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :type, as: :select, options: { 'Car': :car, 'Truck': :truck }
    field :foo, as: :text
    field :owner, as: :belongs_to, searchable: true
  end
end
