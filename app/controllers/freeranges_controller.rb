class FreerangesController < ApplicationController
  before_filter :require_login
  before_action :set_freerange, only: [:edit, :update, :destroy]
  
  # Check if a user has the permission to do certain action
  before_action :user_owns, only: [:edit, :update, :destroy]

  # GET /freeranges
  # GET /freeranges.json
  def index
    @user = current_user
    freeranges = @usershown.freeranges
  end

  
  # Given a set of user ids, return @freedates.
  def commonranges
	 @freedates=Freerange.get_common_free_dates(params[:id])
  end
  
  # GET /freeranges/new
  def new
    @freerange = Freerange.new
  end

  # GET /freeranges/1/edit
  def edit
  end

  # POST /freeranges
  # POST /freeranges.json
  def create
    @freerange = current_user.freeranges.build(freerange_params) 
    respond_to do |format|
      if @freerange.save
        format.html { redirect_to current_user}
        format.json { render action: 'show', status: :created, location: @freerange }
      else
        format.html { render action: 'new' }
        format.json { render json: @freerange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /freeranges/1
  # PATCH/PUT /freeranges/1.json
  def update
    respond_to do |format|
      if @freerange.update(freerange_params)
        format.html { redirect_to current_user }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @freerange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /freeranges/1
  # DELETE /freeranges/1.json
  def destroy
    @freerange.destroy
    respond_to do |format|
      format.html { redirect_to current_user}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_freerange
      @freerange = Freerange.find(params[:id])
	  @user=current_user
    end

    def freerange_params
      params.require(:freerange).permit(:start_date, :end_date)
    end
	
	# Redirects the user if he is not the owner of a freerange.
	def user_owns
		if !@freerange.owns_range(@user)
            redirect_to @user
	    end
	end
end
