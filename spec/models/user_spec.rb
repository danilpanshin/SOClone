require 'rails_helper'

RSpec.describe User do
  context 'association' do
    it { should have_many :answers }
    it { should have_many :questions }
  end

  context 'validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe '#author?' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:some_other_user) { create(:user) }

    it 'should return true if current user associates with question' do
      expect(user).to be_author(question)
    end

    it 'should return false if current user does not associates with question' do
      expect(some_other_user).to_not be_author(question)
    end
  end  
end