class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :name
      t.string :lastname
      t.string :phone

      t.timestamps
    end
  end
end
