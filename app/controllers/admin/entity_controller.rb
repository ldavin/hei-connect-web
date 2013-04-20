# encoding: utf-8

class Admin::EntityController < AdminController
  ENTITIES = {absences: Absence, course_rooms: CourseRoom, course_teachers: CourseTeacher, course_users: CourseUser,
              courses: Course, grades: Grade, exams: Exam, groups: Group, rooms: Room, sections: Section,
              teachers: Teacher, updates: Update, user_sessions: UserSession, users: User}

  before_filter :check_entity

  # GET /entity
  # GET /entity.json
  def index
    @search = @klass.search(params[:q])
    @entities = @search.result.includes(@klass::ADMIN_INCLUDES).page(params[:page])
    @count = @search.result.count
    @search.build_condition

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entities }
    end
  end

  # GET /entity/1
  # GET /entity/1.json
  def show
    @entity = @klass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entity/new
  # GET /entity/new.json
  def new
    @entity = @klass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entity/1/edit
  def edit
    @entity = @klass.find(params[:id])
  end

  # POST /entity
  # POST /entity.json
  def create
    @entity = @klass.new(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to admin_entity_url(@entity), notice: 'Absence was successfully created.' }
        format.json { render json: @entity, status: :created, location: @entity }
      else
        format.html { render action: "new" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entity/1
  # PUT /entity/1.json
  def update
    @entity = Absence.find(params[:id])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to admin_entity_url(@entity), notice: 'Absence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity/1
  # DELETE /entity/1.json
  def destroy
    @entity = Absence.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to admin_entities_url }
      format.json { head :no_content }
    end
  end
end
