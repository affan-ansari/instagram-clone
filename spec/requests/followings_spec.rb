require 'rails_helper'

RSpec.describe 'Followings', type: :request do
  describe 'GET /index' do
    let!(:user) { create(:user) }
    let!(:follower) { create(:user) }
    let!(:following) { create(:following, user: user, follower: follower, is_accepted: true) }

    context 'when user is not signed in' do
      it 'returns a failure message' do
        get user_followings_path(user)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in' do
      it 'containts buttong to remove follower' do
        sign_in user
        get user_followings_path(user)

        expect(response.status).to eq(200)
        expect(response.body).to include('Remove')
      end
    end

    context 'when signed in user access following of other user' do
      it 'containts buttong to remove follower' do
        sign_in user
        get user_followings_path(follower)

        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'POST /delete' do
    context 'when user is not signed in' do
      let!(:user) { create(:user) }
      let!(:follower) { create(:user) }
      let!(:following) { create(:following, user: user, follower: follower, is_accepted: true) }

      it 'returns a failure message' do
        delete user_following_path(user, following)

        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in and is the followed user and follower request is accepted' do
      let!(:user) { create(:user) }
      let!(:follower) { create(:user) }
      let!(:following) { create(:following, user: user, follower: follower, is_accepted: true) }

      it 'returns a success message' do
        sign_in user
        delete user_following_path(user, following)

        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Successfully destroyed following')
      end
    end

    context 'when user is signed in and is the followed user and follower request is not accepted' do
      let!(:user) { create(:user, is_public: false) }
      let!(:follower) { create(:user) }
      let!(:following) { create(:following, user: user, follower: follower) }

      it 'returns a success message' do
        sign_in user
        delete user_following_path(user, following)

        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Successfully destroyed request')
      end
    end

    context 'when user is signed in and not associated with following' do
      let!(:user) { create(:user, is_public: false) }
      let!(:follower) { create(:user) }
      let!(:following) { create(:following) }

      it 'returns a success message' do
        sign_in user
        delete user_following_path(user, following)

        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'PATCH /update' do
    context 'when user is not signed in' do
      let!(:following) { create(:following) }

      it 'returns a failure message' do
        patch user_following_path(following.user, following), params: { request_status: true }
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in and request is accepted' do
      let!(:following) { create(:following) }

      it 'returns a success message' do
        sign_in following.user
        patch user_following_path(following.user, following), params: { request_status: true }

        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Accepted')
      end
    end

    context 'when user is signed in and request is not accepted' do
      let!(:following) { create(:following) }

      it 'returns a success message' do
        sign_in following.user
        patch user_following_path(following.user, following), params: { request_status: false }
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('Unable to accept')
      end
    end
  end

  describe 'POST /create' do
    context 'when user is not signed in' do
      let!(:user) { create(:user) }

      it 'returns a failure message' do
        post user_followings_path(user)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in and to be followed user is public' do
      let!(:user) { create(:user) }
      let!(:follower) { create(:user) }

      it 'returns a success message' do
        sign_in follower
        post user_followings_path(user)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Successfully created following')
      end
    end

    context 'when user is signed in and to be followed user is private' do
      let!(:user) { create(:user, is_public: false) }
      let!(:follower) { create(:user) }

      it 'returns a success message' do
        sign_in follower
        post user_followings_path(user)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Successfully created Request')
      end
    end
  end
end
