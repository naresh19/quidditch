class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name,:null => false
      t.string :status
      t.integer :age
      t.integer :team_id,:null => false
      t.timestamps
    end
    add_index :players, [:team_id]
  end
end
