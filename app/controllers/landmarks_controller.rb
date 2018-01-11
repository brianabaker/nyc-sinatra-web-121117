class LandmarksController < ApplicationController

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :"/landmarks/index"
  end

  get "/landmarks/new" do
    @figures = Figure.all
    erb :"/landmarks/new"
  end

  post "/landmarks" do
    # binding.pry
    @landmark = Landmark.create(params[:landmark])
    redirect "/landmarks/#{@landmark.id}"
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  patch "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.name = params[:landmark][:name]
    @landmark.figure_id = params[:landmark][:figure_id]
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

  delete "/landmarks/:id/delete" do
    @landmark = Landmark.find(params[:id])
    @landmark.destroy
    redirect "/landmarks"
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

end
