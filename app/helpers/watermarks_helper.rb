module WatermarksHelper

  def watermark_fonts
    {'architectural'=>'architectural',
    'arial'=>'arial',
    'arial bold'=>'arial bold',
    'avant garde medium'=>'avant garde medium',
    'clarendon fortune bold'=>'clarendon fortune bold',
    'classic roman'=>'classic roman',
    'copperplate'=>'copperplate',
    'friz quadrata'=>'friz quadrata',
    'futura'=>'futura',
    'futura bold'=>'futura bold',
    'garamond bold'=>'garamond bold',
    'garamond bold italic'=>'garamond bold italic',
    'garamond regular'=>'garamond regular',
    'helvetica'=>'helvetica',
    'helvetica bold'=>'helvetica bold',
    'kabel'=>'kabel',
    'optima'=>'optima',
    'palatino'=>'palatino',
    'palatino semi bold'=>'palatino semi bold',
    'profile'=>'profile',
    'ribbon'=>'ribbon',
    'ribbon condensed'=>'ribbon condensed',
    'roffe'=>'roffe',
    'sans bold'=>'sans bold',
    'standard block'=>'standard block',
    'times bold'=>'times bold',
    'times bold italic'=>'times bold italic',
    'times new roman'=>'times new roman',
    'trajan bold'=>'trajan bold'}
  end


  def watermark_thumbnail_url(image)
    url_for(image.image.variant(resize: '200x200'))
  end

  def watermark_url(image)
    url_for(image.image.variant(resize: '960x960'))
  end

end
