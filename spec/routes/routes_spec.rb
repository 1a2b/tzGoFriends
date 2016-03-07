require 'spec_helper'
require 'rails_helper'

describe 'Routes', type: :routing do
  describe 'Admin::MessagesController' do
    it 'routes get index' do
      expect(get: 'admin/messages').to route_to(
        controller: 'admin/messages',
        action: 'index'
      )
    end

    it 'routes put update' do
      expect(put: 'admin/messages/1').to route_to(
        controller: 'admin/messages',
        action: 'update',
        id: '1'
      )
    end

    it 'routes post create' do
      expect(post: 'admin/messages').to route_to(
        controller: 'admin/messages',
        action: 'create'
      )
    end
  end

  describe 'Admin::UsersController' do
    it 'routes get index' do
      expect(get: 'admin/users').to route_to(
        controller: 'admin/users',
        action: 'index'
      )
    end

    it 'routes put update' do
      expect(put: 'admin/users/1').to route_to(
        controller: 'admin/users',
        action: 'update',
        id: '1'
      )
    end

    it 'routes put update_all_users' do
      expect(put: 'update_all_users').to route_to(
        controller: 'admin/users',
        action: 'update_all_users'
      )
    end
  end

  describe 'HomeController' do
    it 'routes get index' do
      expect(get: '/').to route_to(
        controller: 'home',
        action: 'index'
      )
    end
  end

  describe 'SessionsController' do
    it 'routes get callback' do
      expect(get: 'callback').to route_to(
        controller: 'sessions',
        action: 'create'
      )
    end

    it 'routes get log_in' do
      expect(get: 'log_in').to route_to(
        controller: 'sessions',
        action: 'new'
      )
    end

    it 'routes delete log_out' do
      expect(delete: 'log_out').to route_to(
        controller: 'sessions',
        action: 'destroy'
      )
    end
  end
end
