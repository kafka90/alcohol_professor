class CreateReplystatuses < ActiveRecord::Migration
  def change
    create_table :replystatuses do |t|
      
      t.integer :reply_id
      t.integer :user_id          
      
      ## 나중에 없애야함
      t.integer :share_count          #공유횟수 카운트(칭호/뱃지시스템때 사용)
      t.integer :evaluation_count     #평가횟수 카운트(칭호/뱃지시스템때 사용)
      ## 여기까지
      
      t.boolean :liked, default: false
      t.boolean :selected, default: false

      t.timestamps null: false
    end
  end
end
