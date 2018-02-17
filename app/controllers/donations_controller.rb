class DonationsController < ApplicationController
  require 'json'
  def index
    @hola = 'hola'
  end

  def results

  end

  def responses
    redirect_to "https://petro.com.co" if params[:ref_payco].nil?
    json = get_ref_payco(params[:ref_payco])
    if json
      donation = Donation.find_by(epayco_ref: params[:ref_payco])
      if donation.nil?
        donation = Donation.create(
          epayco_ref: params[:ref_payco],
          doctype: json['data']['x_customer_doctype'],
          document: json['data']['x_customer_document'],
          name: json['data']['x_customer_name'],
          lastname: json['data']['x_customer_lastname'],
          email: json['data']['x_customer_email'],
          phone: json['data']['x_customer_phone'],
          country: json['data']['x_customer_country'],
          city: json['data']['x_customer_city'],
          address: json['data']['x_customer_address'],
          ip: json['data']['x_customer_ip'],
          amount: json['data']['x_amount'],
          transaction_id: json['data']['x_transaction_id'],
          transaction_date: json['data']['x_transaction_date'],
          x_cod_response: json['data']['x_cod_response'])
      end
      redirect_to "https://petro.com.co/gracias-por-donar?donation_id=#{donation.epayco_ref}"
      # render json: json.inspect
    end
  end

  private
  def get_ref_payco(ref_payco)
    url = "https://secure.epayco.co/validation/v1/reference/#{ref_payco}"
    request = RestClient.get(url)
    request.code == 200 ? JSON.parse(request.body) : nil
  end
end
