# frozen_string_literal: true

require_relative './../rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    describe 'should be a valid user' do
      it 'should return a valid user' do
        user = User.new(email: 'john@gmail.com', password: 'justASimplePass')
        expect(user).to be_valid
      end
    end

    describe 'should be an invalid user' do
      it 'should return an invalid user' do
        user = User.new

        expect(user).not_to be_valid
      end
    end
  end
end
