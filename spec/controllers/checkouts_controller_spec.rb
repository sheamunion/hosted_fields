require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  render_views

  describe "GET #new" do
    it "returns http success" do
      expect(Braintree::ClientToken).to receive(:generate).and_return("your_client_token")
      get :new
      expect(response).to have_http_status(:success)
    end

    it "adds the Braintree client token to the page" do
      expect(Braintree::ClientToken).to receive(:generate).and_return("your_client_token")
      get :new
      expect(response.body).to match /your_client_token/
    end
  end
end