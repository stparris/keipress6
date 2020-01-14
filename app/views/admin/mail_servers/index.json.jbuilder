json.set! :data do
  json.array! @mail_servers do |mail_server|
    json.partial! 'mail_servers/mail_server', mail_server: mail_server
    json.url  "
              #{link_to 'Show', mail_server }
              #{link_to 'Edit', edit_mail_server_path(mail_server)}
              #{link_to 'Destroy', mail_server, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end