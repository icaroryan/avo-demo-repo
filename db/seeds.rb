org1 = Organization.find_or_create_by!(name: "Acme Corp")
org2 = Organization.find_or_create_by!(name: "Globex LLC")

buyer = Buyer.find_or_create_by!(email: "buyer@example.com") do |u|
  u.name = "Buyer One"
end

ws = Workspace.find_or_create_by!(name: "Workspace A", organization: org1)
Membership.find_or_create_by!(user: buyer, workspace: ws)
