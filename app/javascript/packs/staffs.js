/* eslint no-console: 0 */

import Vue from 'vue'
import '../stylesheets/staff'
import App from '../AppStaff.vue'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(App)
    }).$mount()
    document.body.appendChild(app.$el)
})
