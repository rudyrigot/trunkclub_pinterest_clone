class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  before_action :admin_only!, except: [:show, :new, :create, :edit, :update, :destroy]
  before_action :can_edit_only!, only: [:edit, :update, :destroy]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.includes(:user)
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @user = @board.user
    @pins = @board.pins
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)
    @board.user = current_user unless current_user.admin?  # If not admin, can only create board for oneself

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @user = @board.user
    @board.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: 'Board was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:title, :description, :user_id)
    end

    def can_edit_only!
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You were redirected because you are not the owner of that page.' unless @board.can_be_edited_by? current_user }
        format.json { render status: :forbidden unless @board.can_be_edited_by? current_user }
      end
    end
end
