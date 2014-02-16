class Api::V1::LoginController < Api::ApiController

  def index
    params[:user][:ecampus_id].downcase! if params[:user][:ecampus_id]
    @user = User.new(params[:user])

    if Feature.user_login_enabled?
      if User.where(ecampus_id: @user.ecampus_id).any?
        user_db = User.find_by_ecampus_id @user.ecampus_id
        if user_db.authenticate @user.password
          # User logged in
          if user_db.api_token.nil?
            user_db.set_api_token
          end

          update_user_api_activity user_db
          @user = user_db
        else
          @error = OpenStruct.new
          @error.code = 403.1
          @error.message = 'Login/password incorrect'
          render 'api/v1/error', status: 403
        end
      else
        @error = OpenStruct.new
        @error.code = 403.2
        @error.message = 'Compte inconnu, inscris toi sur hei-connect.eu'
        render 'api/v1/error', status: 403
      end
    else
      @error = OpenStruct.new
      @error.code = 503
      @error.message = Feature.user_login_error_message
      render 'api/v1/error', status: 503
    end
  end
end
