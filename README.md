# Hosted Fields exploration

A simple Rails app integrated with the Braintree v.zero API using [Hosted Fields v2][hfv2].

## Demo

See it [in action on Heroku][herokuapp].

## Starting Up

- `bundle`
- [create a Braintree Sandbox][createsandbox]
- create a file `.env` in root and add your [Braintree API credentials][btapicreds]
- `rails s`
- open `localhost:5000` in your preferred browser.

## Client-side functionality:

- requests a client token from server: [`Braintree::ClientToken.generate`][clienttoken]
- makes a [`braintree.setup()`][setup] call to configure Hosted Fields
- [presents a payment form][form] that uses Hosted Fields
- submits a [payment method nonce to server][nonce2server]
- provides feedback indicating whether transaction was successful or not

## Server-side functionality:

- uses payment method nonce to verify the payment method and store it in vault: [`Braintree::PaymentMethod.create()`][pmcreate]
- creates a transaction using this stored payment method: [`Braintree::Transaction.sale()`][sale]

[herokuapp]: https://hosted-fields-v2.herokuapp.com/
[hfv2]: https://developers.braintreepayments.com/guides/hosted-fields/overview/javascript/v2
[createsandbox]: https://www.braintreepayments.com/sandbox
[btapicreds]: https://articles.braintreepayments.com/control-panel/important-gateway-credentials#api-credentials
[clienttoken]: https://developers.braintreepayments.com/reference/request/client-token/generate/ruby
[setup]: https://developers.braintreepayments.com/guides/hosted-fields/setup-and-integration/javascript/v2#braintree.setup
[form]: https://developers.braintreepayments.com/guides/hosted-fields/overview/javascript/v2#demo
[nonce2server]: https://developers.braintreepayments.com/start/hello-client/javascript/v2#send-payment-method-nonce-to-server
[pmcreate]: https://developers.braintreepayments.com/reference/request/payment-method/create/ruby
[sale]: https://developers.braintreepayments.com/reference/request/transaction/sale/ruby
