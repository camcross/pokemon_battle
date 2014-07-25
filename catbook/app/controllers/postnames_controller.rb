class PostnamesController < ApplicationController
  before_action :set_postname, only: [:show, :edit, :update, :destroy]

  # GET /postnames
  # GET /postnames.json
  def index
    @postnames = Postname.all
  end

  # GET /postnames/1
  # GET /postnames/1.json
  def show
  end

  # GET /postnames/new
  def new
    @postname = Postname.new
  end

  # GET /postnames/1/edit
  def edit
  end

  # POST /postnames
  # POST /postnames.json
  def create
    @postname = Postname.new(postname_params)

    respond_to do |format|
      if @postname.save
        format.html { redirect_to @postname, notice: 'Postname was successfully created.' }
        format.json { render :show, status: :created, location: @postname }
      else
        format.html { render :new }
        format.json { render json: @postname.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postnames/1
  # PATCH/PUT /postnames/1.json
  def update
    respond_to do |format|
      if @postname.update(postname_params)
        format.html { redirect_to @postname, notice: 'Postname was successfully updated.' }
        format.json { render :show, status: :ok, location: @postname }
      else
        format.html { render :edit }
        format.json { render json: @postname.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postnames/1
  # DELETE /postnames/1.json
  def destroy
    @postname.destroy
    respond_to do |format|
      format.html { redirect_to postnames_url, notice: 'Postname was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postname
      @postname = Postname.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postname_params
      params.require(:postname).permit(:name, :body)
    end
end
