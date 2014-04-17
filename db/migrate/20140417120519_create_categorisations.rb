class CreateCategorisations < ActiveRecord::Migration
  def change
    create_table :categorisations do |t|
      t.references :category, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
