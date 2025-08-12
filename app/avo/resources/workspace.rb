class Avo::Resources::Workspace < Avo::BaseResource
  self.authorization_policy = WorkspacePolicy
  self.search = {
    query: -> {
             query.ransack(
               id_eq: params[:q],
               name_cont: params[:q],
               m: "or"
             ).result(distinct: false)
           }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :organization,
      as: :belongs_to,
      searchable: true,
      attach_scope: -> { query.where("name IS NOT NULL") }

    field :users,
      as: :has_many,
      through: :memberships
  end
end
