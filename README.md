# Hosted Fields exploration

A simple Rails app integrated with the Braintree v.zero API.

## Starting Up

- bundle
- create a file ".env" and add Braintree API information
- rails s

## Client-side functionality:

- requests a client token from server—Braintree::ClientToken.generate
- makes a braintree.setup() call to configure Hosted Fields
- presents a payment form that uses Hosted Fields
- submits a payment method nonce to server
- provides feedback indicating whether transaction was successful or not

## Server-side functionality:

- uses payment method nonce to verify the payment method and store it in vault—Braintree::PaymentMethod.create()
- creates a transaction using this stored payment method—Braintree::Transaction.sale()
