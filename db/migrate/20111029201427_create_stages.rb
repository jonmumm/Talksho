class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :sessionId
      t.string :state
      t.string :streamId

      t.timestamps
    end
  end
end
