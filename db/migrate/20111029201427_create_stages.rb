class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :sessionId
      t.string :state
      t.string :streamId

      t.timestamps
    end

    add_index :stages, [:sessionId, :state], :unique => true
  end
end
