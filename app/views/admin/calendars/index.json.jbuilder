json.set! :data do
  json.array! @calendars do |calendar|
    json.partial! 'calendars/calendar', calendar: calendar
    json.url  "
              #{link_to 'Show', calendar }
              #{link_to 'Edit', edit_calendar_path(calendar)}
              #{link_to 'Destroy', calendar, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end