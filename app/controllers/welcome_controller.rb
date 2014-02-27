require 'rss'

class WelcomeController < ApplicationController
  layout 'public'

  caches_page :about, :status

  def index
    begin
       @latest_blog_posts = Rails.cache.fetch 'rss-items', expires_in: 5.minutes do
         RSS::Parser.parse(open('http://blog.hei-connect.eu/rss').read, false).items[0...5]
       end
     rescue
       # Do nothing, just continue.  The view will skip the blog section if the feed is nil.
       @latest_blog_posts = nil
     end
    if user_logged_in
      if current_user.user_ok?
        flash[:alert] = "Ca fait longtemps qu'on ne t'avait pas vu ! Pendant ton absence, on a arrêté de synchroniser tes données, mais tu es de retour dans les files d'attentes. Tes données toutes fraiches seront visibles dès demain." if current_user.last_activity < Time.now - 2.month
        redirect_to dashboard_url ecampus_id: current_user.ecampus_id
      else
        redirect_to validate_users_url
      end
    else
      @user = User.new

      respond_to do |format|
        format.html
      end
    end
  end

  def about
  end

  def status
  end


end
