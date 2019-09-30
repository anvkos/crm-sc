import Vue from 'vue'
import iconSet from 'quasar/icon-set/fontawesome-v5.js';
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css';
import 'quasar/dist/quasar.ie.polyfills';
import 'staffApp/assets/styles/quasar.styl';
import {
  Quasar,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QBtn,
} from 'quasar';

Vue.use(Quasar, {
  config: {},

  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QBtn,
  },

  directives: {},

  iconSet: iconSet,

  plugins: {},
});
