class CreateUnivconfirms < ActiveRecord::Migration
  def change
    create_table :univconfirms do |t|
      
    t.string :front_mail       #이메일 앞부분
    t.string :front_mail_code  #이메일 앞부분 암호화
    t.string :conf_code        #앞자리 몇개 커팅
    
    t.string :back_mail        #이메일 뒷부분(학교메일)
    
    t.string :address_mail     #이메일 풀버전

  
      t.timestamps null: false
    end
  end
end
