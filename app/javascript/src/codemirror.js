import CodeMirror from "codemirror/src/codemirror.js";
import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/eclipse.css';
import 'codemirror/mode/htmlmixed/htmlmixed.js';
import 'codemirror/mode/javascript/javascript.js';
import 'codemirror/mode/sass/sass.js';

// import 'codemirror/theme/monokai.css';
// import CodemirrorJS from 'codemirror/mode/javascript/javascript';
// import CodemirrorHTML from "codemirror/mode/htmlmixed/htmlmixed"
// import CodemirrorSCSS from "codemirror/mode/sass/sass"

$(document).on('turbolinks:load', function() {
  $(".codemirror-css").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      theme: "eclipse",
      mode: "sass",
      tabSize: 2
    });
  });
  $(".codemirror-html").each(function() {
    console.log("why no work");
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      theme: "eclipse",
      mode: "htmlmixed",
      tabSize: 4
    });
  });
  $(".codemirror-json").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      theme: "eclipse",
      mode: "javascript",
      tabSize: 2
    });
  });

  if ($("#theme_new_scss_production").length) {
    // var workspace_codemirror =  CodeMirror.fromTextArea($("#theme_new_scss_workspace").get(0), {
    //   lineNumbers: true,
    //   mode: "sass",
    //   tabSize: 2
    // });

    var production_codemirror = CodeMirror.fromTextArea($("#theme_new_scss_production").get(0), {
      lineNumbers: true,
      theme: "eclipse",
      mode: "sass",
      tabSize: 2
    });

    var theme_css = CodeMirror.fromTextArea($("#theme_css").get(0), {
      lineNumbers: true,
      theme: "eclipse",
      mode: "sass",
      tabSize: 2
    });

  }
  if ($("#theme_view").length) {
    var view = 'theme';
    $('.theme-css-link').on('click', function (e) {
      theme_css.refresh();
    });

    $('.theme-link').on('click', function (e) {
      let new_view = e.target.id;
      $("#"+view+"_view").hide();
      $("#"+new_view+"_view").show();
      $('#'+view).removeClass('active');
      $('#'+new_view).addClass('active');
      view = new_view;
      if (view == 'work') {
        workspace_codemirror.refresh();
      }
      if (view == 'prod') {
        production_codemirror.refresh();
      }
    });
  }

});
