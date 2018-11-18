class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :role
      t.string :first_name
      t.string :virtual_first_name
      t.string :user_email
      t.string :gender
      t.integer :chat_limit
      t.string :email_limit
      t.string :is_multisession_allow
      t.integer :select_volume
      t.string :select_ring_type
      t.string :ip_address

      t.timestamps
    end
  end
end
