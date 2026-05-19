import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router/index.js'
import Paginate from 'vuejs-paginate-next'

createApp(App).
use(router).
component('Paginate', Paginate).
mount('#app')
