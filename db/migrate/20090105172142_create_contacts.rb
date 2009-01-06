class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts, :force => true do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
