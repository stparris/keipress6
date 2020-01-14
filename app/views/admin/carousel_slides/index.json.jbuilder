json.set! :data do
  json.array! @carousel_slides do |carousel_slide|
    json.partial! 'carousel_slides/carousel_slide', carousel_slide: carousel_slide
    json.url  "
              #{link_to 'Show', carousel_slide }
              #{link_to 'Edit', edit_carousel_slide_path(carousel_slide)}
              #{link_to 'Destroy', carousel_slide, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end