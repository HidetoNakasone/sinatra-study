
require "sinatra"
require "sinatra/reloader"
require "zip_code_jp"

enable :sessions

def seisei(postNumA, postNumB)
  address = ZipCodeJp.find "#{postNumA}-#{postNumB}"
  return res = {"prefecture":address.prefecture, "prefecture_kana":address.prefecture_kana, "prefecture_code":address.prefecture_code, "city":address.city, "city_kana":address.city_kana, "town":address.town, "town_kana":address.town_kana, "zip_code":address.zip_code}
end

get '/' do
  if session[:res].nil?
    redirect '/form'
  else
    erb :view, :layout => :layout
  end
end

get '/form' do
  erb :form, :layout => :layout
end

post '/form' do
  session[:res]  = seisei(params[:postNumA], params[:postNumB])
  redirect '/'
end
