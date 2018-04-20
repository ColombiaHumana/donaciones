ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ "Total efectivas: #{number_to_currency Donator.where(status: "Aceptada").sum(:amount), locale: :en, unit: "$ ", separator: ",", delimiter: "."}" } do
    columns do
      column do
        panel "Donaciones Por Moderar" do
          table_for Donator.where(validated: false, rejected: false).order("id desc").limit(20) do
            column("Validado") { |donator| status_tag(donator.validated) }
            column("Monto") { |donator| number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "."}
            column("CC") { |donator| "#{donator.doctype}-#{donator.document}" }
            column("Nombres") { |donator| "#{donator.firstname} #{donator.lastname}" }
            column("Ver") { |donator| link_to("Ver", admin_donator_path(donator)) }
          end # table
        end # panel
      end # column

      column do
        panel "Donaciones Efectivas" do
          table_for Donator.where(validated: true).order("id desc").limit(20) do
            column("Estado") { |donator| status_tag(donator.status) }
            column("Monto") { |donator| number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "." }
            column("CC") { |donator| "#{donator.doctype}-#{donator.document}" }
            column("Nombres") { |donator| "#{donator.firstname} #{donator.lastname}" }
            column("Validado Por") { |donator| "#{donator.admin_user.email}" unless donator.admin_user.nil? }
              column("Ver") { |donator| link_to("Ver", admin_donator_path(donator)) }
          end #table
        end #panel
      end # column
    end # columns

    columns do
      column do
        panel "Donaciones Rechazadas" do
          table_for Donator.where(rejected: true).order("id desc").limit(20) do
            column("Rechazado") { |donator| status_tag(donator.rejected) }
            column("Monto") { |donator| number_to_currency donator.amount, locale: :en, unit: "$ ", separator: ",", delimiter: "."}
            column("CC") { |donator| "#{donator.doctype}-#{donator.document}" }
            column("Nombres") { |donator| "#{donator.firstname} #{donator.lastname}" }
            column("Rechazado Por") { |donator| "#{donator.admin_user.email}" unless donator.admin_user.nil? }
            column("Ver") { |donator| link_to("Ver", admin_donator_path(donator)) }
          end
        end
      end
    end
  end # content
end
