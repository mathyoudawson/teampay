class PaymentsController < ApplicationController
  before_action :check_user

  def new
    @payment = Payment.new
    @game = Game.find(params[:game_id])
    @description = payment_description
    @amount = payable_amount
    @email = current_user.email
  end

  def create
    @game = Game.find(params[:game_id])

    retrieve_or_create_customer
    link_user_to_customer
    charge_customer
    create_payment

    redirect_to @game, notice: "Thanks you!"
  end

  private

  def create_payment
    Payment.create!(
      game_id: @game.id,
      customer_id: customer.id,
      stripe_charge_id: charge_customer.id,
      stripe_amount: charge_customer.amount,
      stripe_status: charge_customer.status,
      stripe_paid: charge_customer.paid
    )
  end

  def link_user_to_customer
    current_user.update!(customer_id: customer.id)
  end

  def customer
    @customer ||= Customer.find_or_create_by(
      email: current_user.email,
      name: current_user.name
    )
  end

  def retrieve_or_create_customer
    if customer.stripe_id && !customer.stripe_id.zero?
      Stripe::Customer.retrieve(customer.stripe_id)
    else
      customer.update!(stripe_id: stripe_customer.id)
      stripe_customer
    end
  end

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )
  rescue Stripe::StripeError => e
    flash[:error] = e.message
    render action: 'new'
  end

  def charge_customer
    @charge_customer ||= Stripe::Charge.create(
      :customer    => stripe_customer.id,
      :amount      => payable_amount,
      :description => payment_description,
      :currency    => 'nzd' # TODO: make this a CONST in the model
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render action: 'new'
  end

  def payment_description
    @game.team + ' (' + @game.game_date.to_s + ') - ' + @game.name
  end

  def payable_amount
    @payment_description ||= (@game.cost * 100).to_i
    # TODO: do something smart with @game.cost and players here
  end

  def payment_params
    params.permit(:authenticity_token, :stripeToken, :stripeEmail, :game_id)
  end
end
