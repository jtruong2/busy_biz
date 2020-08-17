class RenameSearchCriteriaToKeyword < ActiveRecord::Migration[6.0]
  def change
    rename_column :searches, :criteria, :keyword
  end
end
