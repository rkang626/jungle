require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'validates that a value User is successfully created' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save!
      expect(@user).to be_present
    end

    it 'validates that a new User does not save if :first_name is nil' do
      @user = User.new(
        first_name: nil,
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(@user.errors.full_messages[0]).to eq("First name can't be blank")
    end

    it 'validates that a new User does not save if :last_name is nil' do
      @user = User.new(
        first_name: 'Test',
        last_name: nil,
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
    end

    it 'validates that a new User does not save if :email is nil' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end

    it 'validates that a new User does not save if :password is nil' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: nil,
        password_confirmation: nil
      )
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password can't be blank")
    end

    it 'validates that a new User does not save if :password and :password_confirmation do not match' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'passwordd'
      )
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it 'validates that a new User does not save if :password does not meet minimum length' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      @user.save
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 8 characters)")
    end
    
    it 'validates that a new User does not save if :email already exists' do
      @first_user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @first_user.save
      @second_user = User.new(
        first_name: 'Test2',
        last_name: 'User2',
        email: 'TEST@test.COM',
        password: 'password',
        password_confirmation: 'password'
      )
      @second_user.save
      expect(@second_user.errors.full_messages[0]).to eq("Email has already been taken")
    end

  end

  describe '.authenticate_with_credentials' do 

    it 'validates that the correct user is returned when correct credentials are provided for an existing user' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq(@user)
    end

    it 'validates that the correct user is returned when correct credentials are provided for an existing user but with leading and trailing spaces in email' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(User.authenticate_with_credentials('  test@test.com  ', 'password')).to eq(@user)
    end

    it 'validates that the correct user is returned when correct credentials are provided for an existing user but with uppercase email' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(User.authenticate_with_credentials('TEST@TEST.COM', 'password')).to eq(@user)
    end

    it 'validates that the correct user is returned when original email provided was in uppercase' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'TEST@TEST.COM',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq(@user)
    end

    it 'validates that nil is returned when incorrect credentials are provided for an existing user' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      expect(User.authenticate_with_credentials('test@test.com', 'password1')).to be_nil
    end

    it 'validates that nil is returned when credentials are provided for a non-existent user' do
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to be_nil
    end

  end

end
