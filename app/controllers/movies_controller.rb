class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   
   #debugger
   if (session[:sort] or session[:ratings]) and !params[:sort] and !params[:ratings]
      redirect_to movies_path( :sort => session[:sort], :ratings => session[:ratings] )
    end

   @all_ratings = Movie.getRatings
   @ratings = (params["ratings"].present? ? params["ratings"] : @all_ratings) 
   @movies = Movie.where(:rating => @ratings)   
   session[:ratings]=@ratings
    @sort = nil
    if params[:sort]!= nil
      @sort = params[:sort]
    end

    if @sort != nil
      @movies = @movies.order(@sort)
      session[:sort]= @sort
    # @movies =  Movie.find(:all, :order =>@sort)xs
    #else
     # @movies = Movie.all
    end

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
