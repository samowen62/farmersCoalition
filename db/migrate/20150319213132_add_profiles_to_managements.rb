class AddProfilesToManagements < ActiveRecord::Migration
  def change
    add_reference :managements, :profile, index: true
  end
end
