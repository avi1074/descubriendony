class SubscribersController < ApplicationController
#  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  # POST /subscribers
  # POST /subscribers.json
   
  def create
    #redirect_to root_url if subscriber_params.email.
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      UserMailer.send_email(@subscriber).deliver
      AdminMailer.send_email(@subscriber).deliver
      redirect_to root_url, notice: 'Thank you for subscribing.'
      
    else
      redirect_to root_url, notice: 'Please enter correct email address.'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
