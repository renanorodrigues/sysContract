require 'rails_helper'

RSpec.describe "UsersBackoffice::Personas", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/users_backoffice/personas/index"
      expect(response).to have_http_status(:success)
    end
  end

end
