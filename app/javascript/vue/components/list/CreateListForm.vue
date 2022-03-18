<template>
  <div class="block p-6 rounded-lg shadow-lg bg-white max-w-md hidden" id="create-list-form">
    <div class="form-group mb-6">
      <span v-if="title.length > 50" class="text-red-500 block">50字以内で入力してください</span>
      <input type="text" class="form-control block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" placeholder="リスト名" v-model="title">
    <span class="block text-right" :class="{ 'text-red-500' : title.length > 50 }">{{ title.length }}/50</span>
    </div>
    <button type="button" class="
      w-full
      px-6
      py-2.5
      bg-green-600
      text-white
      font-medium
      text-xs
      leading-tight
      uppercase
      rounded
      shadow-md
      hover:bg-green-700 hover:shadow-lg
      focus:bg-green-700 focus:shadow-lg focus:outline-none focus:ring-0
      active:bg-green-800 active:shadow-lg
      transition
      duration-150
      ease-in-out" @click="createList(currentUser.id)">作成</button>
  </div>
</template>

<script>
import { ref, onMounted, computed, watch } from 'vue'
import Axios from 'axios'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'

Axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  setup() {
    const title = ref('')
    const router = useRouter()
    const store = useStore()

    // create list
    const createList = async (userId) => {
      await Axios.post('/api/v1/users/' + userId + '/lists', {
        title: title.value
      })
                 .then( res => {
                   console.log(res.data.status);
                   initForm(userId)
                   router.push('/')
                 })
                 .catch( err => {
                   console.log(err.response.data.message)
                 })
    }

    // init form
    const initForm = (userId) => {
      title.value = ''
      document.getElementById('create-list-form').classList.add('hidden');
      store.dispatch('getAllLists', userId)
    }

    // onMounted( async () => {
    //   await store.dispatch('getCurrentUser')
    // })

    return {
      title, createList,
      currentUser: computed(() => store.state.currentUser)
    }
  },
}
</script>
