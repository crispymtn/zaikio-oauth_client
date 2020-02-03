# This migration comes from zaikio (originally 20191017132048)
class CreateZaikioAccessTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :zaikio_access_tokens, id: :uuid do |t|
      t.references :bearer, type: :uuid, polymorphic: true, index: true
      t.string :token, null: false, index: { unique: true }
      t.string :refresh_token, index: { unique: true }
      t.datetime :expires_at, index: true
      t.string :scopes, array: true, default: [], null: false
      t.timestamps
    end
  end
end