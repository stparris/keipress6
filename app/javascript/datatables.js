//= require datatables/jquery.dataTables

// optional change '//' --> '//=' to enable

// require datatables/extensions/AutoFill/dataTables.autoFill
// require datatables/extensions/Buttons/dataTables.buttons
// require datatables/extensions/Buttons/buttons.html5
// require datatables/extensions/Buttons/buttons.print
// require datatables/extensions/Buttons/buttons.colVis
// require datatables/extensions/Buttons/buttons.flash
// require datatables/extensions/ColReorder/dataTables.colReorder
// require datatables/extensions/FixedColumns/dataTables.fixedColumns
// require datatables/extensions/FixedHeader/dataTables.fixedHeader
// require datatables/extensions/KeyTable/dataTables.keyTable
// require datatables/extensions/Responsive/dataTables.responsive
// require datatables/extensions/RowGroup/dataTables.rowGroup
// require datatables/extensions/RowReorder/dataTables.rowReorder
// require datatables/extensions/Scroller/dataTables.scroller
// require datatables/extensions/Select/dataTables.select

//= require datatables/dataTables.bootstrap4
// require datatables/extensions/AutoFill/autoFill.bootstrap4
// require datatables/extensions/Buttons/buttons.bootstrap4
// require datatables/extensions/Responsive/responsive.bootstrap4


//Global setting and initializer

$.extend( $.fn.dataTable.defaults, {
  responsive: true,
  pagingType: 'full',
  //dom:
  //  "<'row'<'col-sm-4 text-left'f><'right-action col-sm-8 text-right'<'buttons'B> <'select-info'> >>" +
  //  "<'row'<'dttb col-12 px-0'tr>>" +
  //  "<'row'<'col-sm-12 table-footer'lip>>"
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


$(document).ready(function(){
  if (!$.fn.DataTable.isDataTable("table[id^=dttb-]")) {
    $("table[id^=dttb-]").DataTable();
  }
});

$(document).ready(function(){
  var dataTable = $($.fn.dataTable.tables(true)).DataTable();
  if (dataTable !== null) {
    dataTable.clear();
    dataTable.destroy();
    return dataTable = null;
  }
});

$(document).ready(function(){
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
