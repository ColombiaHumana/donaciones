ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Donaciones Por Moderar" do
          table_for Donator.where(validated: false).order("id desc").limit(20) do
            column("Estado") { |donator| status_tag(donator.validated) }
            column("Monto") { |donator| number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "."}
            column("CC") { |donator| "#{donator.doctype}-#{donator.document}" }
            column("Nombres") { |donator| "#{donator.firstname} #{donator.lastname}" }
            column("Validar") { |donator| link_to("Validar", admin_donator_path(donator)) }
          end # table
        end # panel
      end # column

      column do
        panel "Donaciones Efectivas" do
          table_for Donator.where(validated: true).order("id desc").limit(20) do
            column("Estado") { |donator| status_tag(donator.validated) }
            column("Monto") { |donator| number_to_currency donator.amount }
            column("CC") { |donator| "#{donator.doctype}-#{donator.document}" }
            column("Nombres") { |donator| "#{donator.firstname} #{donator.lastname}" }
          end #table
        end #panel
      end # column
    end # columns
  end # content
end
