class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.integer :user_id #after adding foreign key to my both models I need to add macros has_many and belongs_to and I have associations

      t.timestamps null: false
    end
  end
end

#after run rake db:migrate I got in db folder schema.db file when I can see shapshot of current structure of db 
# after I create file seeds.db and in there 