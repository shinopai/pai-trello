import {
  createApp
} from 'vue'
import App from '../vue/App.vue'
import CreateListForm from '../vue/components/list/CreateListForm.vue'
import router from '../vue/route/router'
import store from '../vue/store/store'

const app = createApp(App)
app.use(router)
app.use(store)
app.mount('#pai-trello')

const listApp = createApp(CreateListForm)
listApp.use(router)
listApp.use(store)
listApp.mount('#pai-list')
