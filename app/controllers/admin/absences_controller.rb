class Admin::AbsencesController < AdminController
  # GET /absences
  # GET /absences.json
  def index
    @absences = Absence.order('id ASC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @absences }
    end
  end

  # GET /absences/1
  # GET /absences/1.json
  def show
    @absence = Absence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @absence }
    end
  end

  # GET /absences/new
  # GET /absences/new.json
  def new
    @absence = Absence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @absence }
    end
  end

  # GET /absences/1/edit
  def edit
    @absence = Absence.find(params[:id])
  end

  # POST /absences
  # POST /absences.json
  def create
    @absence = Absence.new(params[:absence])

    respond_to do |format|
      if @absence.save
        format.html { redirect_to admin_absence_url(@absence), notice: 'Absence was successfully created.' }
        format.json { render json: @absence, status: :created, location: @absence }
      else
        format.html { render action: "new" }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /absences/1
  # PUT /absences/1.json
  def update
    @absence = Absence.find(params[:id])

    respond_to do |format|
      if @absence.update_attributes(params[:absence])
        format.html { redirect_to admin_absence_url(@absence), notice: 'Absence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @absence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /absences/1
  # DELETE /absences/1.json
  def destroy
    @absence = Absence.find(params[:id])
    @absence.destroy

    respond_to do |format|
      format.html { redirect_to admin_absences_url }
      format.json { head :no_content }
    end
  end
end
