$(document).ready(function(){
  $(".codemirror-css").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      mode: "sass",
      tabSize: 2
    });
  });
  $(".codemirror-html").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      mode: "htmlmixed",
      tabSize: 2
    });
  });
  $(".codemirror-json").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      mode: "json-ld",
      tabSize: 2
    });
  });


});
