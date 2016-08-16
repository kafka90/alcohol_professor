class HomeController < ApplicationController
       
    before_action :authenticate_user!, only: [:article_write, :article_write_process]
    require 'digest/md5'

    def mainpage    
        @articles = Article.all
    end
    
    def mainpage_demo
        @articles = Article.all  
    end
    
    def mainpage_demo2
        @articles = Article.all
    end
    
    def mainpage_demo3
        @articles = Article.all
    end 
            
    def article_write    
    end
    def article_write_process       
        new_post = Article.new
    
        new_post.title =params[:title]
        new_post.share_name = params[:share_name]
        new_post.summary = params[:summary] 
        new_post.contents = params[:contents]
        new_post.my_image = params[:my_image]
        new_post.contact = params[:contact]
        new_post.address = params[:realAddress]
        new_post.main_menu = params[:main_menu]
        new_post.score01 = params[:score01]
        new_post.score02 = params[:score02]
        new_post.score03 = params[:score03]
        
        new_post.save
        
        redirect_to "/home/mainpage"
    end   
    
    def article_modify
    end
    
    def article_delete
    end
    
    def detailpage          
        @this_article = Article.find(params[:id]) 
    end
    
    def detailpage_demo
        @this_article = Article.find(params[:id]) 
    end

    def article_reply
        @my_reply = Reply.new
     
        @my_reply.article_id = params[:article_id]  
        @my_reply.writer = params[:username]   
        @my_reply.writer_email = params[:email]
        #리플에 글쓴이 이름, 이메일 모두 받는다. 리플에 이름 출력 + 수정 삭제시 이중체크
        
        @my_reply.contents = params[:myreply]
        @my_reply.save
        
        redirect_to :back      
    end
    
    
    def univ_select
        univ_hash = Hash.new
        univ_hash['지메일'] = 'gmail.com'
        univ_hash['네이버'] = 'naver.com' 
        univ_hash['성균관대'] = 'skku.edu'
        univ_hash['숙명여대'] = 'sookmyung.ac.kr'
        univ_hash['서울여대'] = 'swu.ac.kr'
        univ_hash['성신여대'] = 'sungshin.ac.kr'
        
        user_univ = params[:univname]
        
        @this_user = Univconfirm.new
        @this_user.front_mail = params[:front_mail]
        @this_user.front_mail_code = Digest::MD5.hexdigest('this_user.front_mail')
  
        @this_user.back_mail = univ_hash[user_univ] 
        @this_user.address_mail = @this_user.front_mail + '@' + @this_user.back_mail
        @this_user.save 
        
        redirect_to "/home/authentication_demo"    
    end
    
     
    def authentication_demo
        @this_user = Univconfirm.all    
    end
    
    
    def email_send
        @this_user = Univconfirm.all
        
        @user_mail = @this_user.last.address_mail
        @confirm_code = @this_user.last.front_mail_code
        
        # UserMailer.test_send.deliver
        # Sesmailer.hello_world.deliver
        Confirm.confirm_email(@user_mail, @confirm_code).deliver_now
        # Confirm.confirm_email.deliver_now
                
        redirect_to "/home/authentication_demo" 
    end
    
    def code_confirm
        this_code = Univconfirm.all
        # user_mail = current_user.email
        # stat = current_user.statuses.where(article_id: id).take
        
        # temp = User.find(id: current_user.id)
        # temp = User.update_attribute(  confirm_check, 1 )        
        # this_user = current_user.users.where(email: user_mail).take
        
        input_code = params[:confirm_code]
        
        if( this_code.last.front_mail_code == input_code )
          temp = User.where(email: current_user.email)
          temp = User.update_attribute( :confirm_check, 1 ) 
          redirect_to "/home/mainpage" 
        else
          redirect_to "/home/authentication_demo" 
        end            
    end
    
    def index
    end
    
    def jongro_skku
    end
    
    def jongro_bangsong
    end
    
    def jongro_hansung
    end
    
    
    
    #좋아요 
    def like_process
      
      id = params[:id].to_i
      liked_article = Article.find(id)
      unless current_user.articles.where(statuses: {liked: true}).include? liked_article
          if current_user.statuses.where(article_id: id).empty?
              Status.create(user_id: current_user.id, article_id: liked_article.id, liked: true, selected: true)
          else
              stat = current_user.statuses.where(article_id: id).take
              stat.liked = true
              stat.selected = true
              stat.save
          end
          liked_article.like += 1
          liked_article.save
      end  
      redirect_to "/home/detailpage_demo/#{id}"
    end
   
   #좋아요취소 
    def like_delete
        id = params[:id].to_i
        canceled_article = Article.find(id)
        stat = current_user.statuses.where(article_id: id).take
        stat.liked = false
        stat.selected = false
        stat.save
        canceled_article.like -= 1
        canceled_article.save
        
        redirect_to "/home/detailpage_demo/#{id}"
    end
    
    #댓글 좋아요 // r.id가 넘어옴.
    def like_process_re
      
      id = params[:id].to_i
      liked_reply = Reply.find(id)
      arti_id = liked_reply.article_id
      unless current_user.replies.where(replystatuses: {liked: true}).include? liked_reply
          if current_user.replystatuses.where(reply_id: id).empty?
              Replystatus.create(user_id: current_user.id, reply_id: id, liked: true, selected: true)
          else
              stat = current_user.replystatuses.where(reply_id: liked_reply.id).take
              stat.liked = true
              stat.selected = true
              stat.save
          end
          liked_reply.like += 1
          liked_reply.save
      end
      redirect_to "/home/detailpage_demo/#{arti_id}"
    end
   
   #댓글좋아요취소 
    def like_delete_re
      
        id = params[:id].to_i
        canceled_reply = Reply.find(id)
        arti_id = canceled_reply.article_id
        stat = current_user.replystatuses.where(reply_id: id).take
        stat.liked = false
        stat.selected = false
        stat.save
        
        canceled_reply.like -= 1
        canceled_reply.save
        
        redirect_to "/home/detailpage_demo/#{arti_id}"
    end
    
    #평가
    def ev
      id = params[:ev_id].to_i
      params_score = params[:rating].to_i
      scored_article = Article.find(id)
      unless current_user.articles.where(statuses: {scored: true}).include? scored_article
          if current_user.statuses.where(article_id: id).empty?
              Status.create(user_id: current_user.id, article_id: id, scored: true, selected: true)
          else
              stat = current_user.statuses.where(article_id: id).take
              stat.scored = true
              stat.selected = true
              stat.save
          end
          scored_article.score += params_score
          scored_article.numOfScore += 1
          scored_article.save
      end  
      redirect_to "/home/detailpage_demo/#{id}"
      
      # id = params[:id].to_i
      # eva = Reply.find(id)
      # eva.score = params[:rating].to_i
      # eva.score_yet = true
      # eva.score_this = params[:rating].to_i
      
      # eva.save
        
      # redirect_to "/home/detailpage/#{id}"
    end
    
    
end
