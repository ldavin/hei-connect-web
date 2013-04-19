class Admin::CourseTeachersController < AdminController
  # GET /course_teachers
  # GET /course_teachers.json
  def index
    @course_teachers = CourseTeacher.order('id ASC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_teachers }
    end
  end

  # GET /course_teachers/1
  # GET /course_teachers/1.json
  def show
    @course_teacher = CourseTeacher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_teacher }
    end
  end

  # GET /course_teachers/new
  # GET /course_teachers/new.json
  def new
    @course_teacher = CourseTeacher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_teacher }
    end
  end

  # GET /course_teachers/1/edit
  def edit
    @course_teacher = CourseTeacher.find(params[:id])
  end

  # POST /course_teachers
  # POST /course_teachers.json
  def create
    @course_teacher = CourseTeacher.new(params[:course_teacher])

    respond_to do |format|
      if @course_teacher.save
        format.html { redirect_to admin_course_teacher_url(@course_teacher), notice: 'Course teacher was successfully created.' }
        format.json { render json: @course_teacher, status: :created, location: @course_teacher }
      else
        format.html { render action: "new" }
        format.json { render json: @course_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_teachers/1
  # PUT /course_teachers/1.json
  def update
    @course_teacher = CourseTeacher.find(params[:id])

    respond_to do |format|
      if @course_teacher.update_attributes(params[:course_teacher])
        format.html { redirect_to admin_course_teacher_url(@course_teacher), notice: 'Course teacher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_teachers/1
  # DELETE /course_teachers/1.json
  def destroy
    @course_teacher = CourseTeacher.find(params[:id])
    @course_teacher.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_teachers_url }
      format.json { head :no_content }
    end
  end
end
