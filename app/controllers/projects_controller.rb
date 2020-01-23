class ProjectsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @projects = Project.all
    if params[:most]
      @projects = Project.most_employees
    end
  end

  def new
    @project = Project.new
    render :new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    render :edit
  end

  def show
    @project = Project.find(params[:id])
    render :show
  end

  def update
    @project = Project.find(params[:id])
    employees = params[:employee_ids].map { |id| Employee.find(id.to_i) }
    @project.employees.each do |employee|
      if employees.exclude?(employee)
        @project.employees.delete(employee)
      end
    end
    employees.each do |employee|
      if @project.employees.exclude?(employee)
        @project.employees << employee
      end
    end
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

end
