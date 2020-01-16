
class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
    render :index
  end

  def new
    @employee = Employee.new
    @divisions = Division.all
    render :new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @divisions = Division.all
    @projects = Project.all
    render :edit
  end

  def show
    @employee = Employee.find(params[:id])
    @division = Division.find(@employee.division_id)
    render :show
  end

  def update
    @employee = Employee.find(params[:id])
    if params[:project_ids]
      projects = params[:project_ids].map { |id| Project.find(id.to_i) }
      @employee.projects.each do |project|
        if projects.exclude?(project)
          @employee.projects.delete(project)
        end
      end
      projects.each do |project|
        if @employee.projects.exclude?(project)
          @employee.projects << project
        end
      end
    end
    if @employee.update(employee_params)
      redirect_to employees_path
    else
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :division_id)
  end
end
