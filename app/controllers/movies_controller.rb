class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
      @sort = params[:sort]
      @ratings = params[:ratings]
      if @ratings 
        @movies = Movie.where({:rating => @ratings.keys}).all
      elsif  
        @movies = Movie.all
      end    
      if @sort
        @movies = @movies.order(@sort).all
        instance_variable_set("@#{@sort}_header", "hilite")
      end  
      @all_ratings = Movie.all_ratings
      logger.debug "teste"
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
