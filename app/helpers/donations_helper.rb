module DonationsHelper
  def get_ref_payco(ref_payco)
    url = "https://secure.epayco.co/validation/v1/reference/#{ref_payco}"
    request = RestClient.get(url)
    request.code == 200 ? JSON.parse(response) : nil
  end
end
