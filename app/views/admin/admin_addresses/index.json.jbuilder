json.set! :data do
  json.array! @admin_addresses do |admin_address|
    json.partial! 'admin_addresses/admin_address', admin_address: admin_address
    json.url  "
              #{link_to 'Show', admin_address }
              #{link_to 'Edit', edit_admin_address_path(admin_address)}
              #{link_to 'Destroy', admin_address, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end