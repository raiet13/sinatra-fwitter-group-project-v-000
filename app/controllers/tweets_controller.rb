
class TweetsController < ApplicationController

  get '/tweets' do
    # puts "Tweets Index Route"
    if logged_in?
      # puts "Session user = #{session[:user_id]}"
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      # puts "User Not Logged In"
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    # puts "New Tweet Route"
    if logged_in?
      # puts "Create New Tweet"
      erb :'/tweets/create_tweet'
    else
      # puts "User Not Logged In"
      redirect to "/login"
    end
  end

  post '/tweets' do
    # puts "New Tweet Params = #{params}"
    tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if tweet.save
      # puts "Save New Tweet"
      redirect to "/tweets/#{tweet.id}"
    else
      # puts "FAILURE TO SAVE TWEET"
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    # puts "Specific Tweet Route"
    if logged_in?
      # puts "Show Tweet"
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      # puts "User Not Logged In"
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    # puts "Edit Tweet Route"
    if logged_in?
      # puts "Allow Edit of Tweet"
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      # puts "User Not Logged In"
      redirect to "/login"
    end
  end

  post '/tweets/:id' do
    # puts "Edit Tweet Params = #{params}"
    tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      # puts "Allow Edit of Tweet"
      tweet.update(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    else
      # puts "Tweet Edit Error"
      redirect to "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    # puts "Delete Tweet Route"
    tweet = Tweet.find(params[:id])
    if logged_in? && tweet.id == current_user.id
      tweet.delete
    end
    redirect to '/tweets'
  end

end

# rspec spec/controllers/application_controller_spec.rb

# learn --f-f << -- only reports the first spec failure
