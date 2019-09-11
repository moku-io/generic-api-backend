# class API::ServicesController < APIController
#   before_action :authenticate_user!
#   #TODO verifica che il role sia abilitato a questo controller
#
#   before_action :set_service, only: [:show, :update, :destroy]
#
#
#   def index
#     @services = Service.all.includes(:tools)
#
#     if stale?(@services)
#       respond_to do |format|
#         format.json { render :index }
#       end
#     end
#   end
#
#   def show
#     if stale?(@service)
#       respond_to do |format|
#         format.json { render :show }
#       end
#     end
#   end
#
#   def create
#     @service = Service.create(service_params)
#     if @service
#       respond_to do |format|
#         format.json { render :show }
#       end
#     else
#       render json: @service.errors, status: :unprocessable_entity
#     end
#   end
#
#   def update
#     if @service.update service_params
#       respond_to do |format|
#         format.json { render :show }
#       end
#     else
#       render json: @service.errors, status: :unprocessable_entity
#     end
#   end
#
#   def destroy
#     @service.destroy!
#       respond_to do |format|
#         format.json { render :show }
#       end
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
