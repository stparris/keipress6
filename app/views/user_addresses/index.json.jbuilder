json.set! :data do
  json.array! @user_addresses do |user_address|
    json.partial! 'user_addresses/user_address', user_address: user_address
    json.url  "
              #{link_to 'Show', user_address }
              #{link_to 'Edit', edit_user_address_path(user_address)}
              #{link_to 'Destroy', user_address, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end