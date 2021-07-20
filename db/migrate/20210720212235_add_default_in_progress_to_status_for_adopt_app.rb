class AddDefaultInProgressToStatusForAdoptApp < ActiveRecord::Migration[5.2]
  def change
    change_column_default :adoption_applications, :status, from: nil, to: 'In Progress'
  end
end
