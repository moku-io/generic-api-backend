# class API::ServicesController < ApiController
#   before_action :authenticate_user!
#   #TODO verifica che il role sia abilitato a questo controller
#
#   before_action :set_service, only: [:show, :update, :destroy]
#
#
#   def index
#     @services = Service.all
#
#     if stale?(@services)
#       render json: { services: @services }
#     end
#   end
#
#   def show
#     if stale?(@service)
#       render json: { service: @service }
#     end
#   end
#
#   def create
#     @service = Service.create(service_params)
#     if @service
#       render json: { service: @service }
#     else
#       render json: @service.errors, status: :unprocessable_entity
#     end
#   end
#
#   def update
#     if @service.update service_params
#       render json: { service: @service }
#     else
#       render json: @service.errors, status: :unprocessable_entity
#     end
#   end
#
#   def destroy
#     @service.destroy!
#     render json: { service: @service }
#   end
#
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_service
#     @service = Service.find(params[:id])
#   end
#
#   # Never trust parameters from the scary internet, only allow the white list through.
#   def service_params
#     params.require(:service).permit(:name, :description)
#   end
# end
