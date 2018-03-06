class DonatorMailer < ApplicationMailer

  def validated_email(donator)
    @donator = donator
    @url = "https://donaciones.petro.com.co/#{donator.slug}"
    mail(to: @donator.email, subject: 'Aprobada Donacion Colombia Humana')
  end

  def moderation_mail(donator)
    @donator = donator
    mail(to: @donator.email, subject: 'Donaciones Colombia Humana')
  end

  def refused_email(donator)
    @donator = donator
    @url = "https://donaciones.petro.com.co/#{donator.slug}/edit"
    mail(to: @donator.email, subject: 'Rechazada Donacion Colombia Humana')
  end

end
