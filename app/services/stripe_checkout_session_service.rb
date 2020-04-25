class StripeCheckoutSessionService
  def call(event)
    puts event
    task = Task.find_by(checkout_session_id: event.data.object.id)
    # help = @task.helps.
    # task.helper = help.user
    # task.status = "in progress"
  end
end
