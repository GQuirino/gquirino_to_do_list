class CreateToDos < ActiveRecord::Migration[7.2]
  def change
    create_table :to_dos do |t|
      t.string :title
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
