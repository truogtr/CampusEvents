class ChangeYearToString < ActiveRecord::Migration
   

  def change
    remove_column "users", "year"
    add_column "users", "year", :string
  end

end
