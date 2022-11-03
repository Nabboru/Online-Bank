class AddVerificationToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :verification, :boolean
  end
end
