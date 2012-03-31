class Notification < ActionMailer::Base
  default from: "Marshall Nunley <marshalln88@swbell.net>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.order_received.subject
  #
  def order_received(order)
    @order = order
    # @greeting = "Hi"

    mail to: order.email, :subject => 'Pragmatic Store Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.order_shipped.subject
  #
  def order_shipped(order)
    # @greeting = "Hi"
    @order = order
    mail to: order.email, :subject => 'Pragmatic Store Order Shipped'
  end


  def order_received2(order)
    @order = order
    # @greeting = "Hi"

    mail to: order.email, :subject => 'Pragmatic Store Order Confirmation'
  end
end
