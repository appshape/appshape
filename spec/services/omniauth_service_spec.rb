require 'rails_helper'

describe OmniauthService do
  describe '#perform' do
    let(:oauth) do
      { 'uid' => uid, 'provider' => 'github', 'email' => email, 'extra' => { 'raw_info' => { 'name' => name }}}
    end
    let(:uid)  { '1234' }
    let(:email) { 'test@test.com' }
    let(:name) { Faker::Name.name }

    subject { OmniauthService.new(oauth, current_user).perform }

    context 'when user is signed in' do
      let(:current_user) { create(:user, :confirmed) }

      it 'assigns identity to signed in user' do
        subject
        expect(Identity.find_by(uid: uid).user_id).to eq current_user.id
      end

      it 'returns signed in user' do
        expect(subject.id).to eq current_user.id
      end
    end

    context 'when user is singed out' do
      let(:current_user) { nil }

      context 'when identity already exists' do
        let!(:identity) { create(:identity, uid: uid) }

        it 'does not create new identity' do
          expect { subject }.to change { Identity.count }.by(0)
        end

        it 'returns user from the identity' do
          expect(subject.id).to eq identity.reload.user_id
        end
      end

      context 'when identity does not exist' do
        it 'creates new identity' do
          expect { subject }.to change { Identity.count }.by(1)
        end

        context 'when user with given email exists in database' do
          let!(:user) { create(:user, :confirmed, email: email) }

          it 'assigns identity to existing user' do
            subject
            expect(Identity.find_by(uid: uid).user_id).to eq user.id
          end
        end

        context 'when user with given email does not exist' do
          it 'creates new user' do
            expect { subject }.to change { User.count }.by(1)
          end

          it 'assigns identity to newly created user' do
            user = subject
            expect(Identity.find_by(uid: uid).user_id).to eq user.id
          end
        end
      end
    end
  end
end