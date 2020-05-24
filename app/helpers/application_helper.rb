module ApplicationHelper

  def copyright(model)
    years = model.copyright_year > 0 && Time.now.year < Time.now.year.to_i ? "#{video.copyright_year.to_S}-#{Time.now.year}" : Time.now.year
    by = model.copyright_by =~ /\S+/ ? model.copyright_by : model.site.name
    return "<icon class=\"icon-copyright\"></icon> #{years} #{by}"
  end

  def process_macros(text)
    text = text.gsub(/{{year}}/,Time.now.year.to_s)
    text = text.gsub(/{{today}}/,Time.now.strftime("%-d %B %Y"))
    text = text.gsub(/{{today-us}}/,Time.now.strftime("%B %-d, %Y"))
    return text
  end

  def macros_button
    %q(
<button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#macroModal">
  <icon class="icon-info-circled"></icon> Macros
</button>)
  end

  def macro_modal
    modal = '
<div class="modal fade" id="macroModal" tabindex="-1" role="dialog" aria-labelledby="macroModal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="macroModalTitle">Macros</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table table-striped table-bordered">
          <thead>
            <tr>
              <th>Macro</th>
              <th>Display</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>{{year}}</td>'
    modal += "               <td>#{Time.now.year.to_s}</td>"
    modal += '            </tr>
            <tr>
              <td>{{today}}</td>'
    modal += "               <td>#{Time.now.strftime("%-d %B %Y")}</td>"
    modal += '            </tr>
            <tr>
              <td>{{today-us}}</td>'
    modal += "               <td>#{Time.now.strftime("%B %-d, %Y")}</td>"
    modal += '            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>'
    return modal
  end

  def icons_button
    %q(
<button type="button" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#iconModal">
  <icon class="icon-info-circled"></icon> Icons
</button>)
  end

  def icon_modal
    modal = '
<div class="modal fade" id="iconModal" tabindex="-1" role="dialog" aria-labelledby="iconModal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="iconModalTitle">Icons</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">'

  collections = icon_collections
    i = 1
    collections.each_key do |collection|
    modal += "
      <div>
        <icon id=\"zoomin_#{i}\" class=\"icon-zoom-in\"></icon>
        <icon id=\"zoomout_#{i}\" class=\"icon-zoom-out\" style=\"display:none;\"></icon>
        &nbsp;#{collection}
      </div>
      <div id=\"collection_#{i}\" style=\"display:none;\" class=\"icon-collection\">"
    i += 1
    collections[collection].each do |icon|
        modal += "
        <div class=\"input-group input-group-sm mb-3\">
          <div class=\"input-group-prepend\">
            <span class=\"input-group-text\" id=\"inputGroup-sizing-sm\"><i class=\"icon-#{icon}\"></i>&nbsp;&nbsp;#{icon}</span>
          </div>
          <input id=\"icon_value_#{icon}\" type=\"text\" class=\"form-control icon-tooltip\" aria-label=\"Small\" aria-describedby=\"inputGroup-sizing-sm\" value='<icon class=\"icon-#{icon}\"></icon>' data-toggle=\"tooltip\" data-placement=\"top\" title=\"Copied to clipboard\">
           <span class=\"input-group-btn\">
          <button id=\"icon_btn_#{icon}\" class=\"btn btn-default icon-btn\" type=\"button\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Copy\">
            <icon class=\"icon-docs\"></icon>
          </button>
        </span>
        </div>"
    end
       modal += '</div>'
  end

      modal += '
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>'
    return modal
  end

end
