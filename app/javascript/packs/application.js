// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("jquery-ui")
require('jquery-ui/ui/widgets/sortable');

import $ from 'jquery';
global.$ = jQuery;

import 'jquery-ui/themes/base/core.css';
import 'jquery-ui/themes/base/menu.css';
import 'jquery-ui/themes/base/autocomplete.css';
import 'jquery-ui/themes/base/theme.css';



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// Libraries, formerly gems
require("bootstrap");
import datatables from "datatables.net-bs4"
require("datatables.net-bs4/css/dataTables.bootstrap4.min.css")
require("@fortawesome/fontawesome-free")
import summernote from "summernote"


// require("codemirror/src/codemirror.js")


import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.css")

// Legacy JQuery/Javascript
require("src")



// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
