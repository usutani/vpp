# coding: utf-8
class LicensesController < ApplicationController
  before_action :set_license, only: [:show, :notify]

  # GET /licenses/sync
  def sync
    ActiveRecord::Base.transaction do
      License.delete_all
      begin
        licenses = Vpp::Application.config.vpp_client.get_licenses[:licenses]
      rescue => e
        flash[:notice] = '同期に失敗しました'
        raise ActiveRecord::Rollback
      end
      licenses.each do |vl|
        l = License.find_or_initialize_by(license_id: vl[:license_id])
        vl[:status].downcase!
        l.update(vl)
        l.prepare_content
      end
      flash[:notice] = 'VPPストア情報と同期しました'
    end
    redirect_to action: 'index'
  end

  # GET /licenses
  def index
    @licenses = License.all
  end

  # GET /licenses/1
  def show
  end

  # GET /licenses/1/associate/1
  def associate
    user_id = User.find(params[:user_id]).user_id
    license_id = License.find(params[:id]).license_id
    h = {user_id: user_id, license_id: license_id}
    begin
      Vpp::Application.config.vpp_client.associate_license_with_user(h)
      redirect_to action: 'sync'
    rescue => e
      redirect_to license_path, notice: e.message
    end
  end

  # GET /licenses/1/disassociate
  def disassociate
    license_id = License.find(params[:id]).license_id
    Vpp::Application.config.vpp_client.disassociate_license_from_user(license_id: license_id)
    redirect_to action: 'sync'
  end

  # GET /licenses/1/notify
  def notify
    mail = UserMailer.notify(@license)
    mail.transport_encoding = "8bit"
    mail.deliver
    redirect_to action: 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = License.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def license_params
      params.require(:license).permit(:license_id, :user_id, :adam_id, :product_type_id, :its_id_hash, :pricing_param, :status, :product_type_name, :is_irrevocable, :client_user_id_str)
    end
end
