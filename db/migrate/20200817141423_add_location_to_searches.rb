class AddLocationToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :location, :string
  end
end
