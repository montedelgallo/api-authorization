# frozen_string_literal: true

require_relative './../rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'When user is not authorized' do
    it 'should now allow the user to proceed further' do
      get :index
      body = JSON.parse(response.body)

      expect(response).to have_http_status(403)
      expect(body['error']).not_to be_nil
    end
  end

  # context "When user has superadmin privileges" do
  #   it 'Should allow the user to visit any action and controller' do 
  #     get :index
  #   end
  # end
  
end
