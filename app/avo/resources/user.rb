class Avo::Resources::User < Avo::BaseResource
  self.authorization_policy = UserPolicy
  self.search = {
    query: -> {
             query.ransack(
               id_eq: params[:q],
               name_cont: params[:q],
               email_cont: params[:q],
               m: "or"
             ).result(distinct: false)
           }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :email, as: :text
    field :type, as: :select, options: { Buyer: "Buyer" }

    field :workspaces,
      as: :has_many,
      through: :memberships
  end
end
