class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      
      t.string    :name, default:"新規チャット"
      t.text      :explain

      t.timestamps
    end
  end
end
