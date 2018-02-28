class DonatorMailer < ApplicationMailer

  def validated_email(donator)
    @donator = donator
    @url = "https://donaciones.petro.com.co/#{donator.slug}"
    mail(to: @donator.email, subject: 'Donaciones Colombia Humana')
  end
  
end
