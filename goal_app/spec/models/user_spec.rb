require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe "validations" do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}

    it {should validate_length_of(:password).is_at_least(6) }
  end
  # describe "associations"
  describe "::find_by_credentials" do
    context "invalid credentials" do
      it "returns nil" do
        expect(User.find_by_credentials(user.username, "sdfg")).to be_nil
      end

    end
    context "valid credentials" do
      it "returns user" do
        expect(User.find_by_credentials(user.username, "password")).to eq(user)
      end
    end
  end

  describe '#is_password?' do
    context 'correct password' do
      it "returns true" do
        expect(user.is_password?("password")).to be true
      end

    end
    context 'incorrect password' do
      it "returns false" do
        expect(user.is_password?("pasfghsword")).to be false
      end
    end
  end

end
