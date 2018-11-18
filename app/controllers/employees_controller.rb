class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  require 'socket'
  def index
    # @employees = Employee.all.page(params[:page]).per(10)
    condition = []
    if params[:query].present?
      condition << "employees.role LIKE '%#{params[:query]}%'"
      condition << "employees.first_name LIKE '%#{params[:query]}%'" 
      condition << "employees.virtual_first_name LIKE '%#{params[:query]}%'" 
      condition << "employees.user_email LIKE '%#{params[:query]}%'" 
      condition << "employees.gender LIKE '%#{params[:query]}%'" 
      # condition << "employees.chat_limit LIKE '%#{params[:query].to_i}%'"
      # condition << "employees.email_limit LIKE '%#{params[:query].to_i}%'" 
      # condition << "employees.select_volume LIKE '%#{params[:query].to_i}%'"
      # condition << "employees.select_ring_type LIKE '%#{params[:query].to_i}%'" 
    end

    condition = condition.join(' or ')
    @employees = Employee.where(condition).order(:id).page(params[:page]).per(5)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    @employee.ip_address = ip.ip_address
    # ip.ip_address if ip
    puts"===========ip#{ip.ip_address}"
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:role,:first_name,:virtual_first_name,:user_email,:gender,:chat_limit,:email_limit,:is_multisession_allow,:select_volume,:select_ring_type,:ip_address)
    end
end
