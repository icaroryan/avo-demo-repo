class Avo::Resources::Organization < Avo::BaseResource
  self.authorization_policy = OrganizationPolicy
  self.search = {
    query: -> {
             query.ransack(
               id_eq: params[:q],
               name_cont: params[:q],
               m: "or"
             ).result(distinct: false)
           },
    item: -> do
            {
              title: "[#{record.id}] #{record.name}"
            }
          end
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :workspaces, as: :has_many
  end
end
