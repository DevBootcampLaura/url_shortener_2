get '/' do
  erb :index
end

post '/urls' do
  input = params[:long_url]
  @data = Url.create!(long_url: input, click_count: 0)
  erb :show_url
end


get '/:short_url' do
  params[:short_url]
  @data = Url.find_by(short_url: params[:short_url])
  @data.click_count += 1
  @data.save
  redirect to("#{@data.long_url}")
end
