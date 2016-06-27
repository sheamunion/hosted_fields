class CustomersController < ApplicationController

	def new
		@customer = Customer.new
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
 			Braintree::Customer.create(
        :id                   => @customer.id,
        :first_name           => @customer.first_name,
        :last_name            => @customer.last_name,
      )
			session[:customer_id] = @customer.id
			redirect_to new_checkout_path
		else
			redirect_to new_customer_path
		end
	end

	def show
		@customer = Customer.find(params[:id])
	end

	private

	def customer_params
		params.require(:customer).permit(
																			:first_name,
																			:last_name,
																			:payment_method_nonce
																		)
	end

end