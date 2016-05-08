class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :set_authorized_boards, only: [:new, :create, :edit, :update]
  before_action :authenticate_user!

  before_action :admin_only!, except: [:show, :new, :create, :edit, :update, :destroy]
  before_action :can_edit_only!, only: [:edit, :update, :destroy]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.includes(board: :user)
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    @board = @pin.board
    @user = @board.user
  end

  # GET /pins/new
  def new
    redirect_to new_board_path, notice: "You must create a board first, before adding a pin to it!" if Board.where(user: current_user).count == 0
    @pin = Pin.new
    @pin.board_id = params['board_id'] if params['board_id'].present?
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = Pin.new(pin_params)

    respond_to do |format|
      if !current_user.admin? && @pin.board.user != current_user
        format.html { redirect_to user_path(current_user), alert: 'You can only pin to your own boards.' }
        format.json { render json: {}, status: :unauthorized }
      elsif @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    @pin.assign_attributes(pin_params)
    respond_to do |format|
      if !current_user.admin? && @pin.board.user != current_user
        format.html { redirect_to @pin, alert: 'You can only pin to your own boards.' }
        format.json { render json: @pin, status: :unauthorized }
      elsif @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @board = @pin.board
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to board_path(@board), notice: 'Pin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:title, :description, :board_id, :link)
    end

    def can_edit_only!
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You were redirected because you are not the owner of that page.' unless @pin.can_be_edited_by? current_user }
        format.json { render status: :forbidden unless @pin.can_be_edited_by? current_user }
      end
    end

    def set_authorized_boards
      if current_user.admin?
        @boards = Board.includes(:user)
      else
        @boards = Board.includes(:user).where(user: current_user)
      end
    end
end
