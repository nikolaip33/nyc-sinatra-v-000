class FiguresController < ApplicationController
    
    get '/figures' do
        @figures = Figure.all
        erb :"/figures/index"
    end


    get '/figures/new' do
        @titles = Title.all
        @landmarks = Landmark.all
        erb :"/figures/new"
    end

    post '/figures' do
        
        @figure = Figure.create(params[:figure])
        @figure.landmarks.find_or_create_by(params[:landmark]) unless params[:landmark][:name].empty?
        @figure.titles.find_or_create_by(params[:title]) unless params[:title][:name].empty?

        redirect "/figures/#{figure.id}"
    end

    get '/figures/:id' do
        @figure = Figure.find_by(id:params[:id])

        erb :"/figures/show"
    end

    patch '/figures/:id' do
        @figure = Figure.find_by(id:params[:id])
        @figure.update(params[:figure])
        @figure.landmarks.find_or_create_by(params[:landmark]) unless params[:landmark][:name].empty?
        @figure.titles.find_or_create_by(params[:title]) unless params[:title][:name].empty?
        redirect "/figures/#{figure.id}"
    end

    get '/figures/:id/edit' do
        @figure = Figure.find_by(id:params[:id])
        @titles = Title.all
        @landmarks = Landmark.all
     
        erb :"/figures/edit"
    end
end