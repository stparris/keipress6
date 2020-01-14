json.set! :data do
  json.array! @rentals do |rental|
    json.partial! 'rentals/rental', rental: rental
    json.url  "
              #{link_to 'Show', rental }
              #{link_to 'Edit', edit_rental_path(rental)}
              #{link_to 'Destroy', rental, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end