class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def sync
    Vpp::Application.config.vpp_client.get_users[:users].each do |vu|
      user = User.find_or_initialize_by(client_user_id_str: vu[:client_user_id_str])
      user.update(vu)
    end
    redirect_to action: 'index'
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    h = user_params.select { |key,_| vpp_user_key_filter.include? key }
    h["client_user_id_str"] = SecureRandom.uuid
    Vpp::Application.config.vpp_client.register_user(h.symbolize_keys)

    @user = User.new(user_params)
    @user.client_user_id_str = h["client_user_id_str"]

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    h = user_params.select { |key,_| vpp_user_key_filter.include? key }
    Vpp::Application.config.vpp_client.edit_user(h.symbolize_keys)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:client_user_id_str, :email, :its_id_hash, :status, :user_id)
    end

    def vpp_user_key_filter
      filter= %w[client_user_id_str email]
    end
end
