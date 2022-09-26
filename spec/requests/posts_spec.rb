require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    let!(:following) { create(:following, user: user, follower: follower, is_accepted: true) }
    let!(:user_post) { create(:post, user: user, caption: 'Test post') }
    let!(:follower) { create(:user) }
    let!(:user) { create(:user) }

    context 'when user is not signed in' do
      it 'returns a failure message' do
        get '/posts'
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when follower is signed in' do
      it 'containts caption of post created by followed user' do
        sign_in follower
        get '/posts'
        expect(response.body).to include('Test post')
        expect(response.status).to eq(200)
      end
    end

    context 'when logged in user is not following anyone' do
      it 'does not containt caption of any post' do
        sign_in user
        get '/posts'
        expect(response.body).not_to include('Test post')
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET /show' do
    context 'when user is not signed in' do
      let!(:user) { create(:user) }
      let!(:user_post) { create(:post, user: user, caption: 'Test post') }

      it 'returns a failure message' do
        get post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when follower is signed in and user is public' do
      let!(:user) { create(:user) }
      let!(:user_post) { create(:post, user: user, caption: 'Test post') }
      let!(:follower) { create(:user) }

      it 'containts caption of post created by followed user' do
        sign_in follower
        get post_path(user_post)
        expect(response.body).to include('Test post')
        expect(response.status).to eq(200)
      end
    end

    context 'when follower is signed in, user is private and user is not followed' do
      let!(:user) { create(:user, is_public: false) }
      let!(:follower) { create(:user) }
      let!(:user_post) { create(:post, user: user, caption: 'Test post') }

      it 'returns a authorization failure message' do
        sign_in follower
        get post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end

    context 'when follower is signed in, user is private and user is followed' do
      let!(:user) { create(:user, is_public: false) }
      let!(:follower) { create(:user) }
      let!(:user_post) { create(:post, user: user, caption: 'Test post') }
      let!(:following) { create(:following, user: user, follower: follower, is_accepted: true) }

      it 'containts caption of post created by followed user' do
        sign_in follower
        get post_path(user_post)
        expect(response.status).to eq(200)
        expect(response.body).to include('Test post')
      end
    end
  end
end
