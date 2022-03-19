<template>
  <div class="block p-6 rounded-lg shadow-lg bg-white w-2/3 mx-auto mt-10">
    <div class="form-group mb-6">
      <label for="card-title">タイトル</label>
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
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" placeholder="カード名(30文字以内)" v-model="title" id="card-title">
    <span class="block text-right" :class="{ 'text-red-500' : title.length > 30 }">{{ title.length }}/30</span>
    </div>
    <div class="form-group mb-6">
      <label for="card-memo">メモ</label>
      <textarea id="card-memo" cols="30" rows="5" class="form-control block
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
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" placeholder="詳細(100文字以内)" v-model="memo"></textarea>
    <span class="block text-right" :class="{ 'text-red-500' : memo.length > 100 }">{{ memo.length }}/100</span>
    </div>
    <div class="form-group mb-6">
      <label for="card-list" class="block">リスト名</label>
      <select v-model="listId" id="card-list" class="w-1/3 border p-1">
        <option v-for="list in allLists" :key="list" :value="list.id">{{ list.title }}</option>
      </select>
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
      ease-in-out" @click="updateCard">更新</button>
  </div>
</template>

<script>
import { computed, ref } from 'vue'
import Axios from 'axios'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'

Axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props: {
    id: String
  },
  setup(props) {
    const cardId = props.id
    const title = ref('')
    const memo = ref('')
    const listId = ref()
    const router = useRouter()
    const store = useStore()

    // get edit card
    const getEditCard = async () => {
      await Axios.get('/api/v1/cards/' + cardId + '/edit_card')
                 .then( res => {
                   console.log(res.data)
                   title.value = res.data.title
                   memo.value = res.data.memo
                   listId.value = res.data.list_id
                 })
                 .catch( err => {
                   console.log(err.response.data)
                 })
    }

    // init function
    const initFunc = async () => {
      await store.dispatch('getCurrentUser')
      await store.dispatch('getAllLists', store.state.currentUser.id)
    }

      getEditCard()
      initFunc()

    // update new card
    const updateCard = async () => {
      await Axios.patch('/api/v1/cards/' + cardId, {
        title: title.value,
        memo: memo.value,
        list_id: listId.value
      })
                 .then( res => {
                   console.log(res.data.status)
                   goHome()
                 })
                 .catch( err => {
                   console.log(err.response.data.message)
                 })
    }

    // go to home
    const goHome = () => {
      router.push('/')
    }

    return {
      title, memo, listId, updateCard,
      allLists: computed(() => store.state.allLists)
    }
  },
}
</script>
