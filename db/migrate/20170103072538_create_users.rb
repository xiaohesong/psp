class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.string :salt
      t.string :encrypted_password
      t.boolean :admin, default: false
      t.datetime :last_sign_in_at

      t.timestamps
    end
  end
end
