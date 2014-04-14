class MakeRegistrationsAJoinTable < ActiveRecord::Migration
  def up
    Registration.destroy_all
    remove_column :registrations, :full_name
    remove_column :registrations, :email
    add_column :registrations, :user_id, :integer
  end

  def down
    Registration.destroy_all
    remove_column :registrations, :user_id
    add_column :registrations, :full_name, :string
    add_column :registrations, :email, :string
  end
end
