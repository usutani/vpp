class LicensesController < ApplicationController
  before_action :set_license, only: [:show]

  def sync
    License.delete_all
    Vpp::Application.config.vpp_client.get_licenses[:licenses].each do |vl|
      License.find_or_initialize_by(license_id: vl[:license_id]).update(vl)
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

  def associate
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
