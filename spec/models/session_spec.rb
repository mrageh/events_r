require 'spec_helper'

describe Session do
  describe '.new' do
    it 'works without options' do
      expect(Session.new).not_to raise_exception
    end

    it 'works with options' do
      session = Session.new(email:'tes@example.com', password: 'password' )

      expect(session.email).to eq 'tes@example.com'
      expect(session.password).to eq 'password'
    end
  end

  describe '#user' do
    context 'with valid credentials' do
      it 'returns user object' do
        user = User.create(user_attributes(
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )) 
        session = Session.new(email: 'test@example.com', password: 'password')

        expect(session.user).to eq user
      end
    end

    context 'with valid email address and bad password' do
      it 'returns false' do
        user = User.create(user_attributes(
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )) 
        session = Session.new(email: 'test@example.com', password: 'badpassy')

        expect(session.user).to be_false
      end
    end

    context 'with bad email address' do
      it 'returns nil' do
        session = Session.new(email: 'cool@example.com', password: 'password')

        expect(session.user).to be_nil
      end
    end
  end
end
