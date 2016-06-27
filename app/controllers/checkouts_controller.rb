class CheckoutsController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def show
  	@transaction = Braintree::Transaction.find(params[:id])
  end

  def create
    # @customer  = Customer.find(session[:customer_id])
    amount     = params[:amount]
    nonce      = params[:payment_method_nonce]

    # begin
    #   customer = Braintree::Customer.find(@customer.id)
    # rescue Braintree::NotFoundError => e
    #   puts e.message
    # end

    # puts "===============>>>>>>>>>>>>> #{customer.inspect}"

    # begin
      result_payment_method = Braintree::PaymentMethod.create(
        :customer_id          => "3",
        # :first_name           => params[:first_name],
        # :last_name            => params[:last_name],
        :payment_method_nonce => nonce,
        :options              => {
                                   :verify_card => true
                                   # :fail_on_duplicate_payment_method => true
                                 }
      )
    # rescue Braintree::ErrorResult => e
    #   puts e.message
    # end

    result_transaction = Braintree::Transaction.sale(
      :amount => amount,
      :payment_method_token => result_payment_method.payment_method.token,
    )

    if result_transaction.success?
			redirect_to checkout_path(result_transaction.transaction.id)
    else
      @errors = result_transaction.errors
      @errors.each do |error|
        puts "ERROR #{error.code}: #{error.message} \n\n"
      end
    	redirect_to new_checkout_path
    end

  end

end
