json.set! :data do
  json.array! @mail_application do |mail_template|
    json.partial! 'mail_application/mail_template', mail_template: mail_template
    json.url  "
              #{link_to 'Show', mail_template }
              #{link_to 'Edit', edit_mail_template_path(mail_template)}
              #{link_to 'Destroy', mail_template, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end