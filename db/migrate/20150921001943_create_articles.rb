class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      
      t.string :title       #술집이름
      t.string :share_name  #공유자
      t.string :share_university 
      
      t.string :summary     #한줄요약
      t.text :contents      #장문소개
      
      t.string :my_image    #술집사진aws upload용
      t.string :contact     #술집연락처
      t.string :address     #술집주소
      t.string :main_menu   #대표메뉴
      
      
      t.integer :score, default: 0
      t.integer :numOfScore, default: 0
      t.integer :like, default: 0 
      t.boolean :fame, default: false


      t.timestamps null: false
    end
  end
end
