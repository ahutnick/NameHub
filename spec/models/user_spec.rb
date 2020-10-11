require 'rails_helper'

RSpec.describe User, type: :model do
  let! (:user) { create(:user) }

  describe 'User creation' do
    it 'works with valid name and email' do
      expect(user.valid?)
    end

    it 'does not allow user with empty name' do 
      user.name = "  "
      expect(user.valid?).to be false
    end

    it 'does not allow user with empty email' do 
      user.email = "  "
      expect(user.valid?).to be false
    end

    it 'does not allow invalid address' do
      invalid_addresses = %w[user@example,com useratexampledotcom user@example@user.com user@example+user.com]
      invalid_addresses.each do |ia| 
        user.email = ia
        expect(user.valid?).to be false
      end 
    end

    it 'does not allow duplicate email addresses' do
      duplicate_user = user.dup
      user.save
      expect(duplicate_user.valid?).to be false
    end

    it 'is case-insensitive' do
      mixed_case = "eMAil@eXAmple.cOM"
      user.email = mixed_case
      user.save!
      expect(user.reload.email).to eq(mixed_case.downcase)
    end

    it 'does not allow blank password' do
      user.password = user.password_confirmation = "     "
      expect(user.valid?).to be false
    end

    it 'has a password minimum length' do
      user.password = user.password_confirmation = "aaaaa"
      expect(user.valid?).to be false
    end

    it 'throws a fit with non-matching passwords' do
      @user = User.new(name: "Sample User", email: "user@example.com",
        password: "password", password_confirmation: "passwords")
      expect(@user.valid?).to be false
    end
  end

  describe 'Authentication' do 
    it 'returns false with nil value' do 
      expect(user.authenticated?('')).to eq false
    end
  end
end
