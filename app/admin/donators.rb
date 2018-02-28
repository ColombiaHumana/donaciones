ActiveAdmin.register Donator do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  actions :index, :show

  index do
    column :document
    column :firstname
    column :lastname
    column :amount
    actions
  end

  member_action :lock, method: :put do
    resource.update validated: !resource.validated
    DonatorMailer.validated_email(resource).deliver_later unless !resource.validated?
    redirect_to resource_path, notice: "Donacion validada!"
  end

  action_item :verify, only: :show do
    link_to 'Verificar', :lock_admin_donator, method: :put
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
            column ("Validado") { |donator| status_tag(donator.validated) }
          end
        end

      end

    end
    panel "Verificacion" do
      table_for(donator) do
        column("RUT") { |donation| image_tag donation.rut_image(:medium) }
        column("CC") { |donation| image_tag donation.doc_image(:medium) }
      end
    end
  end
end
