require 'rails_helper'

RSpec.describe "UsersBackoffice::Documents", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/users_backoffice/documents/index"
      expect(response).to have_http_status(:success)
    end
  end

end
