ActiveAdmin.register Donator do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :reason, :rejected
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  actions :index, :show, :edit, :update

  index do
    column("Verificado"){|donator| status_tag(donator.validated) }
    column ("Estado") { |donator| status_tag(donator.status) }
    column :document
    column :firstname
    column :lastname
    column('Monto') { |donator| number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "."}

    actions
  end

  member_action :validate, method: :put do
    resource.update validated: true, rejected: false, admin_user: current_admin_user
    Log.create text: "#{current_admin_user.email} realizó la validación de la donación #{resource.doctype}-#{resource.document}"
    DonatorMailer.validated_email(resource).deliver_later unless !resource.validated?
    redirect_to resource_path, notice: "Donacion validada!"
  end

  # member_action :refuse, method: :put do
  #   resource.update rejected: true, validated: false, admin_user: current_admin_user
  #   DonatorMailer.refused_email(resource).deliver_later
  #   redirect_to resource_path, notice: "Donacion Rechazada!"
  # end

  action_item :verify, only: :show do
    link_to 'Verificar', :validate_admin_donator, method: :put unless resource.validated? || resource.rejected?
  end

  # action_item :reject, only: :show do
  #   link_to 'Rechazar', :refuse_admin_donator, method: :put unless resource.rejected? || resource.validated?
  # end

  action_item :update_status, only: :index do
    link_to 'Actualizar Estado', :update_status, method: :post
  end

  show title: proc{| donator | "#{donator.doctype}-#{donator.document} #{number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "."}"} do
    panel "Detalles de la donacion" do
      columns do
        column do
          table_for(donator) do
            column :firstname
            column :lastname
            column("Documento") { |donation| "#{donation.doctype}-#{donation.document}"}
            column('Monto') { |donator| number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "."}
            column :email
            column :mobilephone
            column ("Rechazado") { |donator| status_tag(donator.rejected) } unless resource.x_ref_payco
            column ("Validado") { |donator| status_tag(donator.validated) } unless resource.x_ref_payco
            column ("Estado") { |donator| status_tag(donator.status) } unless resource.x_ref_payco.nil?
            column ("Epayco") { |donator| status_tag(donator.x_ref_payco) } unless resource.x_ref_payco.nil?
          end
        end

      end

    end
    panel "Verificacion" do
      table_for(donator) do
        column("RUT") do |donation|
          link_to donation.rut_image.url do
            image_tag donation.rut_image(:medium)
          end
        end
        column("CC") do |donation|
          link_to donation.doc_image.url do
            image_tag donation.doc_image(:medium)
          end
        end
      end
    end
  end

  form title: "Rechazar Donación" do |f|
    inputs do
      input :reason
    end

    para "Preciona cancelar para volver a la lista"
    actions
  end

  controller do
    def update
      DonatorMailer.refused_email(resource).deliver_later unless resource.rejected
      Log.create text: "#{current_admin_user.email} rechazó la donación #{resource.doctype}-#{resource.document}" unless resource.rejected
      resource.update  reason: params[:donator][:reason], rejected: true
      redirect_to resource_path, notice: "Donacion Rechazada!"
    end
  end
end
