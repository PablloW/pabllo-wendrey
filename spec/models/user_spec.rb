require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'scopes' do
    let!(:company1) { Company.create!(name: 'Company 1') }
    let!(:company2) { Company.create!(name: 'Company 2') }

    let!(:user1) { User.create!(username: 'user_1_1', display_name: 'User 1', email: 'user1@example.com', company: company1) }
    let!(:user2) { User.create!(username: 'user_1_2', display_name: 'User 2', email: 'user2@example.com', company: company1) }
    let!(:user3) { User.create!(username: 'user_1_3', display_name: 'User 3', email: 'user3@example.com', company: company1) }
    let!(:user4) { User.create!(username: 'user_2_1', display_name: 'User 4', email: 'user4@example.com', company: company2) }

    context '.by_company' do
      it 'returns only users from company 1' do
        results = User.by_company(company1.id)
        expect(results).to all(have_attributes(company_id: company1.id))
      end

      it 'returns empty if the company does not exist' do
        results = User.by_company(999)
        expect(results).to be_empty
      end
    end

    context '.by_username' do
      it 'partial and case-insensitive search' do
        results = User.by_username('user_1')
        expect(results.pluck(:username)).to include('user_1_1', 'user_1_2', 'user_1_3')
      end

      it 'returns empty if there is no match' do
        results = User.by_username('zzzz')
        expect(results).to be_empty
      end
    end

    context 'scope chaining' do
      it 'returns users filtered by company and username' do
        results = User.by_company(company1.id).by_username('user_1_2')
        expect(results.count).to eq(1)
        expect(results.first.username).to eq('user_1_2')
      end
    end
  end
end
