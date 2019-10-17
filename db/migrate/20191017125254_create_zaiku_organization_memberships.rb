class CreateZaikuOrganizationMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :zaiku_organization_memberships, type: :uuid do |t|
      t.references :organization, null: false, index: true, foreign_key:  { to_table: :zaiku_organizations }
      t.references :person, null: false, index: true, foreign_key: { to_table: :zaiku_people }
      t.string :roles, array: true, null: false, default: []
      t.timestamps
    end
  end
end
