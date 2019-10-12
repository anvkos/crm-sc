import Vue from 'vue';
import App from '../AppStaff.vue';
import router from 'staffApp/router';
import 'staffApp/quasar';
import store from 'staffApp/store';


document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(App),
        router,
        store,
    }).$mount()
    document.body.appendChild(app.$el)
});
