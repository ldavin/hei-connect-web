class Admin::CourseUsersController < AdminController
  # GET /course_users
  # GET /course_users.json
  def index
    @course_users = CourseUser.order('id ASC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_users }
    end
  end

  # GET /course_users/1
  # GET /course_users/1.json
  def show
    @course_user = CourseUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_user }
    end
  end

  # GET /course_users/new
  # GET /course_users/new.json
  def new
    @course_user = CourseUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_user }
    end
  end

  # GET /course_users/1/edit
  def edit
    @course_user = CourseUser.find(params[:id])
  end

  # POST /course_users
  # POST /course_users.json
  def create
    @course_user = CourseUser.new(params[:course_user])

    respond_to do |format|
      if @course_user.save
        format.html { redirect_to admin_course_user_url(@course_user), notice: 'Course user was successfully created.' }
        format.json { render json: @course_user, status: :created, location: @course_user }
      else
        format.html { render action: "new" }
        format.json { render json: @course_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_users/1
  # PUT /course_users/1.json
  def update
    @course_user = CourseUser.find(params[:id])

    respond_to do |format|
      if @course_user.update_attributes(params[:course_user])
        format.html { redirect_to admin_course_user_url(@course_user), notice: 'Course user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_users/1
  # DELETE /course_users/1.json
  def destroy
    @course_user = CourseUser.find(params[:id])
    @course_user.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_users_url }
      format.json { head :no_content }
    end
  end
end
