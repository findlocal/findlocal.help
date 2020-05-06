class TasksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_and_authorize_task, only: [:edit, :update, :destroy]

  def index
    @tasks = filtered_tasks
   if params[:search].blank? 
    @markers = []
    @tasks.each do |task|
    @markers << {lat: task.latitude, 
      lng: task.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { task: task })
    }
  end
    elsif params[:search].blank? == false

    @markers = []
    filter_tasks_by_search_params(params[:search]).each do |task| 

     @markers << {
    
    lat: task.latitude, 
    lng: task.longitude,
    infoWindow: render_to_string(partial: "info_window", locals: { task: task })
    }
    end 
  end
end

  def show
    @task = Task.find(params[:id])
    @tasks = Task.all
    authorize @task
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

    if @help.user.stripe_account.blank?
      # This error shouldn't ever go off, since you can't apply until you have a stripe account
      flash[:error] = "This user does not have a method of receiving payments"
      redirect_to dashboard_path
    else

      image = current_user.avatar.attached? ? [Cloudinary::Utils.cloudinary_url(@help.user.avatar.key)] : []

      # TODO: set up a transfer if the user already has a stripe account (this will be easier, since you won't have to enter your info)
      session = Stripe::Checkout::Session.create(
        {
          payment_method_types: ["card"],
          customer_email: current_user.email,
          line_items: [{
            name: "Help from #{@help.user.first_name} #{@help.user.last_name} for #{@task.title}",
            images: image,
            amount: @help.bid_cents,
            currency: "eur",
            quantity: 1
          }],
          # this points the transaction to the helper's connected stripe account
          payment_intent_data: {
            application_fee_amount: (@help.bid_cents * 0.05).round,
            on_behalf_of: @help.user.stripe_account,
            transfer_data: {
              destination: @help.user.stripe_account
            }
          },
          success_url: dashboard_url,
          cancel_url: dashboard_url
        }
      )

      # TODO: Once we implement a chat feature we should redirect there instead of directly to the payment
      if payment = Payment.create(checkout_session_id: session.id, task: @task, help: @help, completed: false)
        redirect_to payment_path(payment)
      else
        flash[:error] = task_error_message("assign")
        redirect_to dashboard_path
      end

    end
  end

  def complete
    # Right now this runs directly after the "mark as done" button is pressed, later we should make it run after a review is made
    @task = Task.find(params[:task_id])
    authorize @task

    if @task.update(status: "completed")
      flash[:success] = "#{@task.title} complete!"

    else
      flash[:error] = "There was an error in marking #{@task.title} as complete."

    end
    redirect_to dashboard_path
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
      # Gabriele, I am removing this because users should be able to see their tasks on the dashboard as well - in Airbnb you can see your own posting.
      # .where.not(creator: current_user)
      .order(:created_at)
  end

  def filter_tasks_by_search_params(params)
    location = params[:location]
    task_tags = params[:task_tags]
    @tasks = if task_tags.nil? || task_tags == ""
               @tasks.where("location ILIKE ?", "%#{location}%")
             else
               @tasks.joins(:tags).where(tags: { name: task_tags }).where("location ILIKE ?", "%#{location}%")
           end
    # due_date = params[:due_date].present? && Date.parse(params[:due_date])

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
