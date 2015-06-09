class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :team1_id,:null => false
      t.integer :team2_id,:null => false
      t.integer :team1_score,:default=>0
      t.integer :team2_score,:default=>0
      t.string :status
      t.timestamps
    end
  end
end
