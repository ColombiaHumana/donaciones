ActiveAdmin.register Log do
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
  actions :index

  index do
    column("Auditoria"){|log| log.text }
    column("Donacion"){|log| link_to "#{log.donator.doctype}-#{log.donator.document}", admin_donator_path(log.donator) unless log.donator.nil?}
    column("Responsable"){|log| link_to log.admin_user.email, admin_admin_users_path(log.admin_user) unless log.admin_user.nil?}

  end
end
