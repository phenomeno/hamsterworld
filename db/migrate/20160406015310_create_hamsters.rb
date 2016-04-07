class CreateHamsters < ActiveRecord::Migration
  def self.up
      create_table :hamsters do |t|
          t.string :name
          t.string :color
          t.integer :hunger
          t.integer :stress
          t.integer :health
          t.float :survival
     end
  end

  def self.down
      drop_table :hamsters
  end
end
