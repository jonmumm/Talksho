class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :sessionId
      t.string :streamId
      t.string :state

      t.timestamps
    end
  end
end
