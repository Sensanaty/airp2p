import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import "flatpickr/dist/flatpickr.css";
import "flatpickr/dist/themes/dark.css";


import { initMapbox } from '../plugins/init_mapbox';
initMapbox();



import { initFlatpicker } from '../plugins/init_flatpickr';
initFlatpicker();





