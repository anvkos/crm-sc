/* eslint no-console: 0 */

import Vue from 'vue'
import App from '../AppClient.vue'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(App)
    }).$mount()
    document.body.appendChild(app.$el)

    console.log(app)
})
