import {
  createRouter,
  createWebHistory
} from "vue-router";
import Index from '../components/Index.vue';
import CreateCardForm from '../components/card/CreateCardForm.vue';
import EditCardForm from '../components/card/EditCardForm.vue';
import CardDetail from '../components/card/CardDetail.vue';

const routes = [{
    path: '/',
    component: Index
  },
  {
    path: '/lists/:list_id/card/new',
    component: CreateCardForm,
    name: 'create-card-form',
    props: true
  },
  {
    path: '/cards/:id/detail',
    component: CardDetail,
    name: 'card-detail',
    props: true
  },
  {
    path: '/cards/:id/edit',
    component: EditCardForm,
    name: 'edit-card-form',
    props: true
  }
]

const router = createRouter({
  history: createWebHistory(),
  base: process.env.BASE_URL,
  routes
})

export default router
