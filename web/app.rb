require 'sinatra'
require './marsrover.rb'

class NotFound < Exception; end


get '/rovers' do
  @rovers = Rover.all
  haml :index
end


get '/rovers/:id' do
  @rover = Rover.get(params[:id])
  raise NotFound unless @rover
  haml :show
end


get '/rovers/:id/edit' do
  @rover = Rover.get(params[:id])
  haml :edit
end

put '/rovers/:id' do
  @rover = Rover.get(params[:id])
  raise NotFound unless @rover
  @rover.update(params[:rover])
  if @rover.save
    redirect "/rovers"
  else
    haml :edit
  end
end

