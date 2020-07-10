module AdminsHelper

  def template_collection
    templates = []
    if  Dir.exists?("#{Rails.root}/app/views/admin/#{controller_name}/templates")
      template_folder = Dir.new("#{Rails.root}/app/views/admin/#{controller_name}s/templates")
      template_folder.each do |file|
        next if file =~ /^\./
        templates << {'name'=>file.split(/_/).map(&:capitalize).join(' '),'value'=> file.gsub(/^_|\.html.erb/,'')}
      end
    end
  end

  def icon_collections
    collections = {}
    collection = []
    cname = nil
    File.open("#{Rails.root}/app/assets/stylesheets/keipress-fontello.scss", "r") do |f|
      f.each_line do |line|
        next unless line =~ /^\.icon|^\/\*\*\s/
        if line =~ /\/\*\*\s(.*)\s\*\//
          cname = $1
          collections[cname] = []
          next
        end
        # .icon-star:before { content: '\e800'; } /* '' */
        collections[cname] << line.gsub(/\.icon-|:.*|\n/,'')
      end
    end
    return Hash[collections.sort]
  end

  def object_table(obj)
    author_hash = {}
    roles = {'1' => 'Super Admin','2' => 'Site Admin','3' => 'Content Admin'}
    yes_no = {'0' => 'No','1' => 'Yes','2' => 'No'}
    false_true = {'false' => 'No','true' => 'Yes','2' => 'No'}
    active_inactive = {'1' => 'Active', '2' => 'Inactive'}
    macro = nil
    timestamps = nil
    html = '
<table class="table table-bordered admin-table">
  <tbody>'
    obj.attributes.each do |a|
      name = a[0]
      if name == 'id'
        next unless controller_name =~ /admins|users/
      end

      value = a[1]
      next if name =~ /^type|scss|salt|hash|token|position|container_row_id|rows_flag|text_html_flag|icalendar|sequence/
      next if name =~ /include_admin_handle|include_update_time/ && controller_name != 'blog_posts'
      next if name =~ /include_caption|include_copyright|include_description/ && !(obj.has_attribute?('image_id') && obj.image)
      next if value == nil
      if name =~ /(\S+)_id$/
        class_name = $1
        attr_obj = class_name.camelize.constantize.find(value)
        if attr_obj && name =~ /user_id|admin_id/
          value = link_to raw("#{attr_obj.full_name} <icon class=\"icon-right-hand\"></icon>"), "/admin/#{class_name}s/#{attr_obj.id}"
        elsif attr_obj && name == 'image_id' && attr_obj.image
          if attr_obj.image.attached?
            value = link_to "/admin/#{class_name}s/#{attr_obj.id}" do
              image_tag attr_obj.image.variant(resize: "100x100")
            end
          else
            value = link_to raw("Upload #{attr_obj.name}  <icon class=\"icon-right-hand\"></icon>"), "/admin/#{class_name}s/#{attr_obj.id}"
          end
        elsif attr_obj && name == 'content_id'
          value = link_to raw("#{attr_obj.name} <icon class=\"icon-right-hand\"></icon>"), "/admin/content_groups/#{attr_obj.id}"
        elsif attr_obj && name == 'site_id'
          value = attr_obj.name
        elsif attr_obj && name =~ /country_id|state_id/
          value = attr_obj.name
        elsif attr_obj && name == 'category_id'
          value = link_to raw("#{attr_obj.name} <icon class=\"icon-right-hand\"></icon>"), "/admin/categories/#{attr_obj.id}"
        elsif attr_obj && attr_obj.has_attribute?('name')
          value = link_to raw("#{attr_obj.name} <icon class=\"icon-right-hand\"></icon>"), "/admin/#{class_name}s/#{attr_obj.id}"
        elsif attr_obj && attr_obj.has_attribute?('link')
          value = attr_obj.link =~ /http\S*:\/\/\S+/ ? link_to(raw("#{attr_obj.link} <icon class=\"icon-right-hand\"></icon>"), attr_obj.link, target: 'external site') : 'n/a'
          if attr_obj && attr_obj.has_attribute?('body') && attr_obj.body =~ /\S+/
            value += raw(attr_obj.body)
          end
        end
      else
        value = process_macros(value) if name == 'body'
        value = active_inactive[obj.status.to_s] if name == 'status'
        value = (obj.published == 1 ? 'Yes' : 'No') if controller_name == 'pages' && name == 'published'
        value = yes_no[obj.marketing.to_s] if name == 'marketing'
        value = 'No' if value == false
        value = 'Yes' if value == true
        if name == 'created_at' || name == 'updated_at'
        # @site.time_zone obj.name.constantize.in_time_zone("Pacific Time (US & Canada)").strftime("%Y-%m-%d")
          value = value.strftime("%Y-%m-%d")
        end
        value = value.capitalize.gsub(/_/, ' ') if name =~ /type/
      end
      name = name.gsub(/_/, ' ')
      # value = author_hash[a[1]] if name =~ /by$/
      name = name.sub(/\sid/,'').capitalize
      name = name.sub(/Css/, 'CSS')
      name = name.sub(/Url/, 'URL')
      html += "
    <tr>
      <td class=\"attr\">#{name}</td>
      <td>#{value}</td>
    </tr>"
    end
  html += '
  </tbody>
</table>'
    return html.html_safe
  end

  def process_parent_obj(parent)
    parent_text = parent.class.name.split(/(?=[A-Z])/).map(&:capitalize).join(' ')
    parent_controller = parent.class.name.split(/(?=[A-Z])/).map(&:downcase).join('_') + 's'
    parent_controller = parent_controller.sub(/hs/,'hes')
    parent_name = parent && parent.has_attribute?('name') ? parent.name : parent_text
    parent_name = "Row #{parent.position}" if parent && parent.class.name == 'ContainerRow'
    html = ''
    html += '<li class="nav-item">' + link_to(raw("<icon class=\"icon-zoom-in\"></icon> #{parent_name}"), "/admin/#{parent_controller}/#{parent.id}") + '</li>'
  end

  def operations_menu(obj,parents = [])
    include_macro_modal = false
    include_icon_modal = false
    content_item_controllers = ['content_group_items','article_posts','blog_posts']
    macros = ''
    icons = ''
    html = '
<div class="operations">
  <h4>Operations</h4>
  <ul class="nav flex-column">'
    if parents.any?
      parents.each_with_index do |parent,index|
        if index == 0 && controller_name !~ /row_columns|container_rows/
          parent_controller = parent.class.name.split(/(?=[A-Z])/).map(&:downcase).join('_') + 's'
          parent_controller = parent_controller.sub(/hs/,'hes')
          html += '<li class="nav-item">' + link_to(raw("<icon class=\"icon-list\"></icon> #{parent_controller.gsub(/_/,' ').capitalize}"), "/admin/#{parent_controller}") + '</li>'
        end
        html += process_parent_obj(parent)
      end
    elsif controller_name =~ /image_optimizations|image_uploads/
      html += '<li class="nav-item">' + link_to(raw("<icon class=\"icon-list\"></icon> Images"), "/admin/images") + '</li>'
    else
      html += '<li class="nav-item">' + link_to(raw("<icon class=\"icon-list\"></icon> #{controller_name.gsub(/_/,' ').capitalize}"), "/admin/#{controller_name}") + '</li>'
    end
    if obj
      obj_text = obj.class.name.split(/(?=[A-Z])/).map(&:capitalize).join(' ')
      obj_text = 'Column' if obj.class.name == 'RowColumn'
      obj_text = 'Row' if obj.class.name == 'ContainerRow'
      obj_controller = obj.class.name.split(/(?=[A-Z])/).map(&:downcase).join('_') + 's'
      obj_controller = obj_controller.sub(/ss$/,'ses')
      obj_controller = obj_controller.sub(/hs$/,'hes')
      obj_controller = obj_controller.sub(/ys$/,'ies') unless obj_controller == 'payment_gateways'
      obj_name = obj.has_attribute?('name') ? obj.name : obj_text
      obj_name = "Column #{obj.position}" if obj.class.name == 'RowColumn'
      if action_name =~ /edit|new/
        if (obj.has_attribute?('content_type') && obj.content_type =~ /text|html/) ||
          (obj.has_attribute?('item_type') && obj.item_type)
          include_macro_modal = true
          include_icon_modal = true
        end
        if controller_name =~ /navigation/
          include_macro_modal = true
          include_icon_modal = true
        end
      end
      if action_name == 'edit' && obj_controller == 'videos'
        html += '
        <li class="nav-item">' + link_to(raw("<icon class=\"icon-zoom-in\"></icon> #{obj_name}"), "/admin/media/#{obj.id}") + '</li>'
      elsif action_name =~ /edit/ and not controller_name =~ /content_group_text_items/
        html += '
        <li class="nav-item">' + link_to(raw("<icon class=\"icon-zoom-in\"></icon> #{obj_name}"), "/admin/#{obj_controller}/#{obj.id}") + '</li>'
      elsif action_name == 'show' && parents.any?
        html += '
        <li class="nav-item">' + link_to(raw("<i class=\"icon-plus\"></i> New #{obj_text}"), "/admin/#{obj_controller}/new?#{parents.last.class.name.underscore}_id=#{parents.last.id}") + '</li>'
      elsif action_name == 'show'
        html += '
        <li class="nav-item">' + link_to(raw("<i class=\"icon-plus\"></i> New #{obj_text}"), "/admin/#{obj_controller}/new") + '</li>'
      end
      html += macros_button if include_macro_modal
      html += icons_button if include_icon_modal
    end
    html += '
  </ul>
</div>'
    html += macro_modal if include_macro_modal
    html += icon_modal if include_icon_modal
    return html.html_safe
  end

  def admin_subs
    ['domains','sites']
  end

  def site_subs
    ['sites','mail_servers','mail_templates','payment_gateways','payment_types','payment_methods']
  end

  def media_subs
    ['images','image_batches','image_previews','image_crops','image_watermarks','image_optimizations','image_groups','image_group_items','carousels','carousel_slides','media']
  end

  def page_subs
    ['pages']
  end

  def navigation_list_subs
    ['navigations','navigation_items','list_groups','list_group_clones','list_group_items','dropdowns','dropdown_items']
  end

  def container_subs
    ['containers','container_clones','container_rows','row_columns']
  end

  def content_subs
    ['categories','content_groups','content_group_items','content_group_clones','content_group_text_items','articles','content_admins','article_posts','blogs','blog_posts']
  end

  def people_subs
    ['admins','admins_sites','users']
  end

  def booking_subs
    ['calendars','bookings','rentals','rental_booking_instructions']
  end

  def product_subs
    ['products','orders']
  end

  def subscription_subs
    ['subscriptions']
  end

  def design_subs
    ['themes','theme_colors','theme_icons','palettes','palette_colors','designers']
  end

end
