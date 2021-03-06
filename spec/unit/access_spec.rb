require 'rails_helper'

describe 'Access' do
  before :each do
    @guest = Fabricate :guest
    @guest.confirm

    @user = Fabricate :user
    @user.confirm

    @administrator = Fabricate :administrator
    @administrator.confirm
  end

  it 'should let user role create post' do
    @post = Fabricate :post, user: @user
    Fabricate :note, post: @post
    @post.access_validation(@user)

    expect(@post.errors.count).to eq 0
  end
  it 'should let administraor role create post' do
    @post = Fabricate :post, user: @administrator
    Fabricate :note, post: @post
    @post.access_validation(@administrator)

    expect(@post.errors.count).to eq 0
  end

  it 'should not let guest role create post' do
    @post = Fabricate :post, user: @guest
    Fabricate :note, post: @post
    @post.access_validation(@guest)

    expect(@post.errors.count).to eq 1
    expect(@post.errors[:access][0]).to eq "You dont have access to do that!"
  end

  it 'should let user group update his own post' do
    @post = Fabricate :post, user: @user
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@user)

    expect(@post.save).to be true
  end

  it 'should let administrator group update all posts' do
    @post = Fabricate :post, user: @user
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@administrator)

    expect(@post.save).to be true
  end

  it 'should not let guest group update any posts' do
    @post = Fabricate :post, user: @user
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@guest)

    expect(@post.save).to be false
  end

  it 'should let user group destroy his own post' do
    @post = Fabricate :post, user: @user
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@user)

    expect(@post.destroy).to be_a_kind_of Post
  end

  it 'should let administrator group destroy all posts' do
    @post = Fabricate :post, user: @user
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@administrator)

    expect(@post.destroy).to be_a_kind_of Post
  end

  it 'should not let guest group destroy any posts' do
    @post = Fabricate :post, user: @guest
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@guest)

    expect(@post.destroy).to be nil
  end

  it 'should not let user group destroy other users posts' do
    @post = Fabricate :post, user: @administrator
    Fabricate :note, post: @post

    @post.title = "This is user"
    @post.access_validation(@user)

    expect(@post.destroy).to be nil
  end
end
