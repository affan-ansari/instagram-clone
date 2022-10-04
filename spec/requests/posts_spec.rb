require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }
    let(:follower) { create(:user) }
    let!(:user_post) { create(:post, user: user, caption: 'Test post') }
    let!(:following) { create(:following, user: user, follower: follower, is_accepted: true) }

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
    let!(:user) { create(:user) }
    let!(:follower) { create(:user) }
    let!(:user_post) { create(:post, user: user, caption: 'Test post') }

    context 'when user is not signed in' do
      it 'returns a failure message' do
        get post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when follower is signed in and user is public' do
      it 'containts caption of post created by followed user' do
        sign_in follower
        get post_path(user_post)
        expect(response.body).to include('Test post')
        expect(response.status).to eq(200)
      end
    end

    context 'when follower is signed in, user is private and user is not followed' do
      let!(:context_user) { create(:user, is_public: false) }
      let!(:context_user_post) { create(:post, user: context_user, caption: 'Test post') }

      it 'returns a authorization failure message' do
        sign_in follower
        get post_path(context_user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end

    context 'when follower is signed in, user is private and user is followed' do
      let!(:context_user) { create(:user, is_public: false) }
      let!(:context_user_post) { create(:post, user: context_user, caption: 'Test post') }
      let!(:context_following) { create(:following, user: context_user, follower: follower, is_accepted: true) }

      it 'containts caption of post created by followed user' do
        sign_in follower
        get post_path(context_user_post)
        expect(response.status).to eq(200)
        expect(response.body).to include('Test post')
      end
    end
  end

  describe 'GET /edit' do
    context 'when user is not signed in' do
      let!(:user) { create(:user) }
      let!(:user_post) { create(:post, user: user, caption: 'Test post') }

      it 'returns a failure message' do
        get post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in and is post owner' do
      let!(:user) { create(:user) }
      let!(:user_post) { create(:post, user: user, caption: 'Test post') }

      it 'containts caption of post created by followed user and Edit button' do
        sign_in user
        get edit_post_path(user_post)
        expect(response.body).to include('Test post')
        expect(response.body).to include('Edit')
        expect(response.status).to eq(200)
      end
    end

    context 'when user is signed in and is not post owner' do
      let!(:user) { create(:user) }
      let!(:user_post) { create(:post, caption: 'Test post') }

      it 'returns a authorization failure message' do
        sign_in user
        get edit_post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'GET /new' do
    context 'when user is not signed in' do
      let!(:user) { create(:user) }

      it 'returns a failure message' do
        get new_post_path
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in' do
      let!(:user) { create(:user) }

      it 'containts create button for post' do
        sign_in user
        get new_post_path
        expect(response.status).to eq(200)
        expect(response.body).to include('Create Post')
      end
    end
  end

  describe 'POST /create' do
    let!(:user) { create(:user) }
    let!(:user_post) { create(:post, user: user, caption: 'Test post') }
    let(:post_params) do
      { caption: 'Test post create action',
        images: [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/avatar.jpg'), 'image/jpg')] }
    end

    context 'when user is not signed in' do
      it 'returns a failure message' do
        post posts_path(user_post)
        expect(response.status).to eq(401)
        expect(response.body).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in' do
      it 'returns a success message' do
        sign_in user

        post posts_path, params: { post: post_params }
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Post was successfully created')
      end

      it 'returns a failiure message message' do
        sign_in user
        post posts_path, params: { post: { caption: 'No image attached test' } }
        # byebug
        expect(response.status).to eq(200)
        expect(response.body).to include('No image attached') ######
        expect(flash[:alert]).to eq('Post was not created')
      end
    end
  end

  describe 'POST /delete' do
    let!(:user) { create(:user) }
    let!(:user_post) { create(:post, user: user, caption: 'Test post') }

    context 'when user is not signed in' do
      it 'returns a failure message' do
        delete post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in and is post owner' do
      it 'returns a success message' do
        sign_in user
        delete post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Post was successfully destroyed')
      end

      it 'returns a failure message' do
        sign_in user
        allow(Post).to receive(:find).and_return(user_post)
        allow(user_post).to receive(:destroy).and_return(false)
        delete post_path(user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('Record was not destroyed') ######
      end
    end

    context 'when user is signed in and is not post owner' do
      let(:context_user_post) { create(:post) }

      it 'returns a success message' do
        sign_in user
        delete post_path(context_user_post)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'PATCH /update' do
    let!(:user) { create(:user) }
    let!(:user_post) { create(:post, user: user, caption: 'Test post') }
    let!(:post_params) do
      { caption: 'Updated' }
    end

    context 'when user is not signed in' do
      it 'returns a failure message' do
        patch post_path(user_post), params: { post: post_params }
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    context 'when user is signed in and is post owner' do
      it 'returns a success message' do
        sign_in user
        patch post_path(user_post), params: { post: post_params }
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Post was successfully updated')
      end

      it 'returns a failiure message' do
        sign_in user
        allow(Post).to receive(:find).and_return(user_post)
        allow(user_post).to receive(:update).and_return(false)
        patch post_path(user_post), params: { post: user.attributes }
        # byebug
        expect(response.status).to eq(200)
        expect(flash[:alert]).to eq('Post was not updated')
      end
    end

    context 'when user is signed in and is not post owner' do
      let(:context_user_post) { create(:post) }
      let(:context_post_params) do
        { caption: 'Updated' }
      end

      it 'returns a success message' do
        sign_in user
        patch post_path(context_user_post), params: { post: context_post_params }
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq('You are not authorized to perform this action')
      end
    end
  end
end
