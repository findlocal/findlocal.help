class StripeCheckoutSessionService
  def call(event)
    payment = Payment.find_by(checkout_session_id: event.data.object.id)
    payment.update(completed: true)

    task = payment.task
    task.update(helper: payment.help.user, status: "in progress")
  end
end
