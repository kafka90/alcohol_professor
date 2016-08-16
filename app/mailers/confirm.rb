class Confirm < ApplicationMailer  
    def confirm_email ggobsari_1_mail, ggobsari_2_content       
         mail from: 'professor.alcohol@gmail.com', 
                to: ggobsari_1_mail, 
           subject: '[술선생]학교 인증 메일입니다',
              body: '인증코드 : ' + ggobsari_2_content 
    end
end
