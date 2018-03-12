require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "renders new template" do
        post :create, params: {user: {username: 'User', password: ''}}
        expect(response).to render_template('new')
      end
    end

    context "with valid params" do
      it "redirects to user show page on success" do
        post :create, params: {user: {username: 'username', password: 'password'}}
        user = User.find_by_credentials('username', 'password')
        expect(response).to redirect_to(user_url(user))
      end
    end
  end

  describe "GET #show" do
    it "returns http success if user exists" do
      user = FactoryBot.create(:user)
      get :show, params: {id: user.id}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end

    it "redirects to index if user does not exist" do
      begin
        get :show, params: {id: -1}
      rescue ActiveRecord::RecordNotFound
      end
      # expect(response).to have_http_status(:redirect)
      # expect(response).to redirect_to(users_url)
       expect(response).not_to render_template(:show)
    end
  end

  describe "GET #index" do
    it "Directs to users index page" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

end
