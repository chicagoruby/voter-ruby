require 'sinatra'
require 'haml'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter    => 'postgresql' ,
  :database   => 'mydatabase' ,
  :username   => 'myusername' ,
  :port       => '5432' ,
  :password   => 'mypassword',
  :host       => 'ec2-107-20-159-188.compute-1.amazonaws.com'  
)

class Tbvote < ActiveRecord::Base
  #
end

get '/' do 
  @runner = Tbvote.find( :all )
  haml :index
end

get '/inc/:id' do
  @runner = Tbvote.find( params[:id] )
  @runner.votes = @runner.votes + 1

  @runner.save
  redirect '/'
end

get '/delete/:id' do
  #
  Tbvote.delete( params[:id] )
  redirect '/'
end

get '/new' do
  haml :new
end

post '/save' do
  @runner = Tbvote.new( :teachme => params[:teachme] )
  @runner.votes = 1
  if @runner.save
    redirect '/'
  else
    "The save failed."
  end
end

get '/test' do
  "testng #{Time.now}"
end

