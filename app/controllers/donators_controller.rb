class DonatorsController < ApplicationController
  before_action :set_donator, only: [:show, :pagado, :pagado_callback, :edit, :update]
  protect_from_forgery except: :pagado_callback
  # GET /donators
  # GET /donators.json
  # def index
  #   @donators = Donator.all
  # end

  # GET /donators/1
  # GET /donators/1.json
  def show
    redirect_to :root unless @donator.validated?
  end

  def validating
  end

  # GET /donators/new
  def new
    redirect_to "https://petro.com.co"
    @donator = Donator.new
  end

  # GET /donators/1/edit
  def edit
  end

  # POST /donators
  # POST /donators.json
  def create
    @donator = Donator.new(donator_params)

    respond_to do |format|
      if @donator.save
        DonatorMailer.moderation_mail(@donator).deliver_later
        format.html { redirect_to validating_url, notice: 'Donator was successfully created.' }
        format.json { render :show, status: :created, location: @donator }

      else
        format.html { render :new }
        format.json { render json: @donator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donators/1
  # PATCH/PUT /donators/1.json
  def update
    respond_to do |format|
      if @donator.update(donator_params)
        @donator.update rejected: false
        format.html { redirect_to validating_url, notice: 'Donator was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  STATUSES = {
    "1" => "Aceptada",
    "2" => "Rechazada",
    "3" => "Pendiente",
    "4" => "Fallida",
    "6" => "Reversada",
    "7" => "Retenida",
    "8" => "Iniciada",
    "9" => "Exprirada",
    "10" => "Abandonada",
    "11" => "Cancelada",
    "12" => "Antifraude"
  }
  # DELETE /donators/1
  # DELETE /donators/1.json
  # def destroy
  #   @donator.destroy
  #   respond_to do |format|
  #     format.html { redirect_to donators_url, notice: 'Donator was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def update_status
    redirect_to :root unless current_admin_user
    Donator.where('x_ref_payco != ""').each do |donator|
      json = get_ref_payco(donator.x_ref_payco)
      if json['success'] == true
        status = json['data']['x_response'] || 'INVALIDA'
        donator.update status: status, x_cod_response: json['data']['x_cod_response']
      end
    end
    redirect_to admin_donators_path, notice: "Estados Actualizados"
  end

  def pagado

  end

  def pagado_callback
    render json: {error: "error"}, status: :unprocessable_entity if params[:x_ref_payco].nil?
    @donator.update(epayco_params)
    @donator.update status: STATUSES[@donator.x_cod_response]
    render json: {ok: "ok"}, status: :ok

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donator
      @donator = Donator.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donator_params
      params.require(:donator).permit(:doctype, :document, :firstname, :lastname, :rut_image, :doc_image, :amount, :email, :mobilephone, :address, :job)
    end

    def epayco_params
      params.permit(:x_ref_payco, :x_transaction_id, :x_signature, :x_cod_response, :x_approval_code)
    end

    def get_ref_payco(ref_payco)
      url = "https://secure.payco.co/pasarela/estadotransaccion?id_transaccion=#{ref_payco}"
      request = RestClient.get(url)
      request.code == 200 ? JSON.parse(request.body) : nil
    end
end
