enable :sessions

get '/' do
  erb :index
end

post '/sign_in' do
  @user = User.authenticate(params[:email], params[:password])
  redirect to('/') if @user == nil

  session[:id] = @user.id
  redirect to("/user_page/#{session[:id]}")
end

get '/user_page/:id'  do
  redirect to('/') if session[:id] == nil
  erb :user_page
end

post '/user_urls' do
  input = params[:long_url]
  @data = Url.create!(long_url: input, click_count: 0, user_id: session[:id])
  redirect to('/user_page')
end

post '/urls' do
  input = params[:long_url]
  @data = Url.create!(long_url: input, click_count: 0)
  erb :show_url
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  @u = User.create!(name: params[:name], email: params[:email], password: params[:password])
  session[:id] = @u.id
  redirect to('/user_page')
end

get '/:short_url' do
  params[:short_url]
  @data = Url.find_by(short_url: params[:short_url])
  @data
  @data.click_count += 1
  @data.save
  redirect to("#{@data.long_url}")
end




