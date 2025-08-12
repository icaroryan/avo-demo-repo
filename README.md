# Avo attach_scope repro

This demo app reproduces an error in Avo when using `attach_scope` on a `belongs_to` field while creating a record from a related resource. In this flow, Avo synthesizes a parent by assigning the grandparent through a collection association, which raises an error.

<img width="1551" height="336" alt="image" src="https://github.com/user-attachments/assets/9fc10004-8720-42d3-b1a1-dc29433a238c" />
"undefined method `each' for an instance of Buyer"

## Setup
1. Populate .env file with the following:
   - `AVO_LICENSE_KEY=your_license_key`
2. Install dependencies:
   - `bundle install`
3. Setup DB and seed:
   - `bin/rails db:migrate db:seed`
4. Run the server:
   - `bin/rails server -p 4000`

## Repro steps
1. Go to Users index: `http://localhost:4000/avo/resources/users`
2. Open the Buyer record (seed creates one with email `buyer@example.com`).
3. In the `workspaces` association, click “Add Workspace” to open the new form, or visit directly:
   - `http://localhost:4000/avo/resources/workspaces/new?via_record_id=1&via_relation=users&via_relation_class=User&via_resource_class=Avo%3A%3AResources%3A%3AUser`
4. In the Workspace form, click the `organization` selector. With `searchable: true` and an `attach_scope` defined, the search request triggers `Avo::SearchController#apply_attach_scope`.
5. Error occurs because the controller tries to synthesize a parent with:
   - `Workspace.new(users: <Buyer>)` where `users` is `has_many`, causing `undefined method each for Buyer`.

## Relevant code (anonymized domain)
- `Workspace` model: belongs_to `organization`; has_many `users` through `memberships`.
- `Avo::Resources::Workspace`:
  - `field :organization, as: :belongs_to, searchable: true, attach_scope: -> { query.where("name IS NOT NULL") }`

## Notes
- The issue reproduces when the new Workspace is created from the User context and the `organization` field has an `attach_scope`.
- Removing `attach_scope` avoids the error.

