class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event,:null => false
      t.integer :match_id,:null => false
      t.integer :player_id
      t.integer :team_id,:null => false
      t.integer :team1_score
      t.integer :team2_score
      t.timestamps
    end
    add_index :events, [:match_id]
  end
end
