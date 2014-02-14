require 'rss'

class WelcomeController < ApplicationController
  layout 'public'

  caches_page :about, :status

  def index
    begin
       @latest_blog_posts = RSS::Parser.parse(open('http://blog.hei-connect.eu/rss').read, false).items[0...5]
     rescue
       # Do nothing, just continue.  The view will skip the blog section if the feed is nil.
       @latest_blog_posts = nil
     end
    if user_logged_in
      if current_user.user_ok?
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
