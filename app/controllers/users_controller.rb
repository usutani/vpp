# coding: utf-8
class UsersController < ApplicationController
  before_action :set_user, only: [:invite, :show, :edit, :update, :destroy]

  def invite
    mail = UserMailer.invite(@user)
    mail.transport_encoding = "8bit"
    mail.deliver
    redirect_to action: 'index'
  end

  def sync
    ActiveRecord::Base.transaction do
      User.delete_all
      begin
        users = Vpp::Application.config.vpp_client.get_users[:users]
      rescue => e
        flash[:notice] = '同期に失敗しました'
        raise ActiveRecord::Rollback
      end
      users.each do |vu|
        user = User.find_or_initialize_by(client_user_id_str: vu[:client_user_id_str])
        vu[:status].downcase!
        user.update(vu)
      end
      flash[:notice] = 'VPPストア情報と同期しました'
    end
    redirect_to action: 'index'
  end

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
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
  def create
    @user = User.new(user_params)

    begin
      if @user.save
        redirect_to users_url, notice: '利用者を登録しました'
      else
        render action: 'new'
      end
    rescue => e
      @user.errors.add :base, e.message
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    begin
      if @user.update(user_params)
        redirect_to users_url, notice: '利用者を更新しました'
      else
        render action: 'edit'
      end
    rescue => e
      @user.errors.add :base, e.message
      render action: 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    begin
      @user.destroy
      redirect_to users_url
    rescue => e
      #flash[:notice] = e.message
      redirect_to users_url, notice: e.message
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
end
