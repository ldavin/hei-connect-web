class Admin::CourseRoomsController < AdminController
  # GET /course_rooms
  # GET /course_rooms.json
  def index
    @course_rooms = CourseRoom.order('id ASC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_rooms }
    end
  end

  # GET /course_rooms/1
  # GET /course_rooms/1.json
  def show
    @course_room = CourseRoom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_room }
    end
  end

  # GET /course_rooms/new
  # GET /course_rooms/new.json
  def new
    @course_room = CourseRoom.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_room }
    end
  end

  # GET /course_rooms/1/edit
  def edit
    @course_room = CourseRoom.find(params[:id])
  end

  # POST /course_rooms
  # POST /course_rooms.json
  def create
    @course_room = CourseRoom.new(params[:course_room])

    respond_to do |format|
      if @course_room.save
        format.html { redirect_to admin_course_room_url(@course_room), notice: 'Course room was successfully created.' }
        format.json { render json: @course_room, status: :created, location: @course_room }
      else
        format.html { render action: "new" }
        format.json { render json: @course_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_rooms/1
  # PUT /course_rooms/1.json
  def update
    @course_room = CourseRoom.find(params[:id])

    respond_to do |format|
      if @course_room.update_attributes(params[:course_room])
        format.html { redirect_to admin_course_room_url(@course_room), notice: 'Course room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_rooms/1
  # DELETE /course_rooms/1.json
  def destroy
    @course_room = CourseRoom.find(params[:id])
    @course_room.destroy

    respond_to do |format|
      format.html { redirect_to admin_course_rooms_url }
      format.json { head :no_content }
    end
  end
end
