class CreateAPIRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.belongs_to :tenant
      t.string :endpoint
      t.string :method
      t.string :params

      t.timestamps null: false
    end
  end
end
