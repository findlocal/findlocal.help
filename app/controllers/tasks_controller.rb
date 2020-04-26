class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_and_authorize_task, only: [:edit, :update, :destroy]

  def index
    @tasks = filtered_tasks
    return if params[:search].blank?

    filter_tasks_by_search_params(params[:search])
  end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = Task.new(creator: current_user, status: "pending", **task_params) # `**` is the spread operator
    authorize @task
    if @task.save
      flash[:success] = task_success_message("created")
      redirect_to dashboard_path
    else
      flash[:error] = task_error_message("create")
      render :new
    end
  end

  def edit; end # just the before_action

  def update
    if @task.update(task_params)
      flash[:success] = task_success_message("updated")
      redirect_to dashboard_path
    else
      flash[:error] = task_error_message("update")
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = task_success_message("deleted")
    else
      flash[:error] = task_error_message("delete")
    end
    redirect_to dashboard_path
  end

  # Other actions:
  def assign
    # find_and_assign_help(params)
    @task = Task.find(params[:task_id])
    @help = Help.find(params[:helper_id])

    authorize @task
    # @task.status = "in progress"

    session = Stripe::Checkout::Session.create(
      {
        payment_method_types: ["card"],
        customer_email: current_user.email,
        line_items: [{
          name: "Help from #{@help.user.first_name} #{@help.user.last_name} for #{@task.title}",
          # TODO: Add avatar of helper here
          amount: @help.bid_cents,
          currency: "eur",
          quantity: 1
        }],
        payment_intent_data: {
          application_fee_amount: (@help.bid_cents * 0.05).round,
          transfer_data: {
            # TODO: Add actual stripe account of helper
            destination: "acct_1Gbq6OBGE20DL2Et"
          }
        },
        success_url: dashboard_url,
        cancel_url: dashboard_url
      }
    )

    # Once we implement a chat feature we should redirect there instead of directly to the payment
    payment = Payment.create(checkout_session_id: session.id, task: @task, help: @help, completed: false)

    redirect_to payment_path(payment)
    # if @task.save
    #   flash[:success] = task_success_message("assigned")

    # else
    #   flash[:error] = task_error_message("assign")
    # end
  end

  def dashboard
    # No need to send any task, we can retrieve them from current_user
    authorize Task # if you don't have any instance, call `authorize` on the model
  end

  private

  def set_and_authorize_task
    @task = Task.find(params[:id])
    authorize @task
  end

  def task_params
    params.require(:task).permit(:title, :description, :location, :status, photos: [], tag_ids: [])
  end

  def filtered_tasks
    policy_scope(Task)
      .where(status: "pending")
      .where.not(creator: current_user)
      .order(:created_at)
  end

  def filter_tasks_by_search_params(params)
    location = params[:location]
    task_tags = params[:task_tags]
    # due_date = params[:due_date].present? && Date.parse(params[:due_date])
    @tasks = @tasks.where("location ILIKE ?", "%#{location}%") unless location.empty?
    @tasks = @tasks.joins(:tags).where(tags: { name: task_tags }) unless task_tags.empty?
    # @tasks = @tasks.where("due_date < ?", due_date) if due_date
  end

  def find_and_assign_help(params)
    @help = Help.find(params[:helper_id])
    @task = Task.find(params[:task_id])
    @task.helper = @help.user
  end

  def task_success_message(action)
    "Task \"#{@task.title}\" successfully #{action}"
  end

  def task_error_message(action)
    "Can't #{action} task, please check the errors and try again"
  end
end
