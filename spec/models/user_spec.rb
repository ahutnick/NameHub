require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User creation' do
    it 'works with valid name and email' do
      @user = User.new(name: "Sample User", email: "user@example.com")
      expect(@user.valid?)
    end

    it 'does not allow user with empty name' do 
      @user = User.new(name: "  ", email: "user@example.com")
      expect(@user.valid?).to be false
    end

    it 'does not allow user with empty email' do 
      @user = User.new(name: "Sample User", email: "   ")
      expect(@user.valid?).to be false
    end

    it 'does not allow invalid address' do
      @user = User.new(name: "Sample User", email: "user@example.com")
      invalid_addresses = %w[user@example,com useratexampledotcom user@example@user.com user@example+user.com]
      invalid_addresses.each do |ia| 
        @user.email = ia
        expect(@user.valid?).to be false
      end 
    end

    it 'does not allow duplicate email addresses' do
      @user = User.new(name: "Sample User", email: "user@example.com")
      duplicate_user = @user.dup
      @user.save
      expect(duplicate_user.valid?).to be false
    end

    it 'is case-insensitive' do
      mixed_case = "eMAil@eXAmple.cOM"
      @user = User.new(name: "Sample User", email: "user@example.com")
      @user.email = mixed_case
      @user.save
      expect(@user.reload.email).to eq(mixed_case.downcase)
    end
  end
end
