require 'spec_helper'

describe User do
  before do
    @user = User.new(
      name: 'Adam',
      email: 'Adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end
  context 'email' do
    it 'is valid' do
      @user.email = 'Adam@example.com'

      expect(@user).to be_valid
    end

    it 'is invalid' do
      @user.email = 'invalid email'

      expect(@user).not_to be_valid
    end

    it 'is invalid when blank' do
      @user.email = ''

      expect(@user).not_to be_valid
    end
  end

  context 'name' do
    it 'is valid' do
      @user.name = 'Adam'

      expect(@user).to be_valid
    end

    it 'is invalid when blank' do
      @user.name = ''

      expect(@user).not_to be_valid
    end
  end
end
