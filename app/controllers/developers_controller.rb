class DevelopersController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_developer, only: [:show, :edit, :update, :destroy]

  # GET /developers
  # GET /developers.json
  def index
    authorize! :index, Employee
    @developers = @organization.employees.developers
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
    authorize! :show, Employee
  end

  # GET /developers/new
  def new
    authorize! :new, Employee
    @developer = @organization.employees.new
  end

  # GET /developers/1/edit
  def edit
    authorize! :edit, Employee
  end

  # POST /developers
  # POST /developers.json
  def create
    authorize! :create, Employee
    @developer = @organization.employees.new(developer_params)
    @developer.password = params[:employee][:name]
    @developer.role = :developer
    @developer.skip_organization_details = true

    respond_to do |format|
      if @developer.save
        format.html { redirect_to developer_url(@developer), notice: 'Developer was successfully created.' }
        format.json { render :show, status: :created, location: @developer }
      else
        format.html { render :new }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developers/1
  # PATCH/PUT /developers/1.json
  def update
    authorize! :update, Employee
    respond_to do |format|
      if @developer.update(developer_params)
        format.html { redirect_to developer_url(@developer), notice: 'Developer was successfully updated.' }
        format.json { render :show, status: :ok, location: @developer }
      else
        format.html { render :edit }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    authorize! :destroy, Employee
    @developer.destroy
    respond_to do |format|
      format.html { redirect_to developers_url, notice: 'Developer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_developer
    @developer = @organization.employees.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def developer_params
    params.require(:employee).permit(
      :name, :email
    )
  end
end
