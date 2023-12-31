class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:category].blank?
      @tasks = Task.all.order("created_at DESC")
    else
      @category_id = Category.find_by_name(params[:category]).id
      @tasks = Task.where("category_id =?", @category_id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, alert: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, alert: 'Task was successfully deleted.'
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :company, :url, :category_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
