# frozen_string_literal: true

require_relative './../rails_helper'

RSpec.describe Permission, type: :model do
  context 'Validations' do
    describe 'should be a valid permission' do
      it 'should return a valid permission' do
        permission = Permission.new(controller: 'users_controller', action: 'new')

        expect(permission).to be_valid
      end
    end

    describe 'should ba an invalid permission' do
      it 'should return an invalid permission' do
        permission = Permission.new

        expect(permission).not_to be_valid
      end
    end
  end
end
