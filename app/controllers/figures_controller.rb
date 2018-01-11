class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/new" do
    erb :"/figures/new"
  end

  post "/figures" do
    @figure = Figure.create(params[:figure])

    params[:figure][:title_ids].each do |title_id|
      title_instance = Title.find(title_id)
      @figure.titles << title_instance
    end

    if !params[:title][:name].empty?
      @new_title= Title.find_or_create_by(params[:title])
      @figure.titles << @new_title
    end

    params[:figure][:landmark_ids].each do |landmark_id|
      landmark_instance = Landmark.find(landmark_id)
      @figure.landmarks << landmark_instance
    end

    if !params[:landmark][:name].empty?
      @new_landmark= Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << @new_landmark
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = @figure.titles.map {|title| title.id}
    @landmarks = @figure.landmarks.map{ |landmark| landmark.id }
    erb :"/figures/edit"
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        title_instance = Title.find(title_id)
        @figure.titles << title_instance
      end
    end

    if !params[:title][:name].empty?
      @new_title= Title.find_or_create_by(params[:title])
      @figure.titles << @new_title
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark_id|
        landmark_instance = Landmark.find(landmark_id)
        @figure.landmarks << landmark_instance
      end
    end

    if !params[:landmark][:name].empty?
      @new_landmark= Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << @new_landmark
    end

    @figure.save
    redirect "/figures/#{@figure.id}"

    # @figure.name = params[:figure][:name]
    # @figure.year_completed = params[:figure][:year_completed]
    # @figure.save
    # redirect "/figures/#{@figure.id}"
  end

  delete "/figures/:id/delete" do
    @figure = Figure.find(params[:id])
    @figure.destroy
    redirect "/figures"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

end
