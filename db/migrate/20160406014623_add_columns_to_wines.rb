class AddColumnsToWines < ActiveRecord::Migration
  def change
    add_column :wines, :name, :string
    add_column :wines, :price_min, :float
    add_column :wines, :price_max, :float
    add_column :wines, :retail, :float
    add_column :wines, :year, :string
    add_column :wines, :varietal, :string
    add_column :wines, :vineyard, :string

  end
end
