class CheckoutsController < ApplicationController
  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def show
  	@transaction = Braintree::Transaction.find(params[:id])
    @result      = _create_result_hash(@transaction)
  end

  def create
    nonce                 = params[:payment_method_nonce]
    result_payment_method = Braintree::PaymentMethod.create(
      :customer_id          => "3",
      :payment_method_nonce => nonce,
      :options              => {
        :verify_card => true
      }
    )

    result_transaction = Braintree::Transaction.sale(
      :amount               => "10",
      :payment_method_token => result_payment_method.payment_method.token,
    )

    if result_transaction.success? || result_transaction.transaction
			redirect_to checkout_path(result_transaction.transaction.id)
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error]  = error_messages
    	redirect_to new_checkout_path
    end
  end

  def _create_result_hash(transaction)
    status = transaction.status

    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        :header  => "Success!",
        :icon    => "success",
        :message => "Your test transaction has been successfully processed."
      }
    else
      result_hash = {
        :header  => "Transaction Failed",
        :icon    => "fail",
        :message => "Your test transaction has a status of #{status}."
      }
    end
  end
end
