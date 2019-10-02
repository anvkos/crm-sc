import Vue from 'vue'
import iconSet from 'quasar/icon-set/fontawesome-v5.js';
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css';
import 'quasar/dist/quasar.ie.polyfills';
import 'staffApp/assets/styles/quasar.styl';
import {
  Quasar,
  QBtn,
  QDialog,
  QDrawer,
  QHeader,
  QLayout,
  QPage,
  QPageContainer,
  ClosePopup,
} from 'quasar';

Vue.use(Quasar, {
  config: {},

  components: {
    QBtn,
    QDialog,
    QDrawer,
    QHeader,
    QLayout,
    QPage,
    QPageContainer,
  },

  directives: {
    ClosePopup,
  },

  iconSet: iconSet,

  plugins: {},
});
