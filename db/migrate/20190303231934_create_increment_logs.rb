class CreateIncrementLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :increment_logs do |t|
      t.references :user, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
