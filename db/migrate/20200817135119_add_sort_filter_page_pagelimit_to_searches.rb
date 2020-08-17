class AddSortFilterPagePagelimitToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :sort_by, :string
    add_column :searches, :filter, :string
    add_column :searches, :page, :string
    add_column :searches, :page_limit, :string
  end
end
