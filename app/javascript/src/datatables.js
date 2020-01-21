
//Global setting and initializer
$(document).on('turbolinks:load', function() {
  $.extend( $.fn.dataTable.defaults, {
    responsive: true,
    pagingType: 'full',
    //dom:
    //  "<'row'<'col-sm-4 text-left'f><'right-action col-sm-8 text-right'<'buttons'B> <'select-info'> >>" +
    //  "<'row'<'dttb col-12 px-0'tr>>" +
    //  "<'row'<'col-sm-12 table-footer'lip>>"
  });
});

$(document).on('preInit.dt', function(e, settings) {
  var api, table_id, url;
  api = new $.fn.dataTable.Api(settings);
  table_id = "#" + api.table().node().id;
  url = $(table_id).data('source');
  if (url) {
    return api.ajax.url(url);
  }
});


$(document).on('turbolinks:load', function() {
  if (!$.fn.DataTable.isDataTable("table[id^=dttb-]")) {
    $("table[id^=dttb-]").DataTable();
  }
});

$(document).on('turbolinks:load', function() {
  var dataTable = $($.fn.dataTable.tables(true)).DataTable();
  if (dataTable !== null) {
    dataTable.clear();
    dataTable.destroy();
    return dataTable = null;
  }
});

$(document).on('turbolinks:load', function() {
  $('#page_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 },
      { orderable: false, targets: 5 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#container_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 },
      { orderable: false, targets: 5 },
      { orderable: false, targets: 6 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#navigation_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 4 },
      { orderable: false, targets: 5 },
      { orderable: false, targets: 6 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#dropdown_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 },
      { orderable: false, targets: 5 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#list_group_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 2 },
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 },
      { orderable: false, targets: 5 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#content_group_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 1 },
      { orderable: false, targets: 2 },
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#article_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 },
      { orderable: false, targets: 5 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#blog_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 1 },
      { orderable: false, targets: 2 },
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#image_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 0 },
      { orderable: false, targets: 5 },
      { orderable: false, targets: 6 },
      { orderable: false, targets: 7 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#carousel_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 0 },
      { orderable: false, targets: 2 },
      { orderable: false, targets: 3 },
      { orderable: false, targets: 4 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#booking_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 5 },
      { orderable: false, targets: 6 },
      { orderable: false, targets: 7 }
    ],
    sPaginationType: "full_numbers"
  });
  $('#content_text_item_index').dataTable({
    columnDefs: [
      { orderable: false, targets: 3 }
    ],
    sPaginationType: "full_numbers"
  });
});
