require 'rails_helper'

RSpec.describe "UsersBackoffice::Comments", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/users_backoffice/comments/index"
      expect(response).to have_http_status(:success)
    end
  end

end
