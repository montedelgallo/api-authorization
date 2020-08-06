# frozen_string_literal: true

require_relative './../rails_helper'

RSpec.describe Role, type: :model do
  context 'Validations' do
    describe 'should be a valid role' do
      it 'should return a valid role' do
        role = Role.new(name: 'cool_role', description: 'only for cool users')

        expect(role).to be_valid
      end
    end
    describe 'should be an invalid role' do
      it 'should return an invalid role' do
        role = Role.new
        expect(role).not_to be_valid
      end
    end
  end
end
