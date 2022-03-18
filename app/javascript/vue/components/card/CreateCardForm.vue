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
      ease-in-out" @click="createCard">作成</button>
  </div>
</template>

<script>
import { ref } from 'vue'
import Axios from 'axios'
import { useRouter } from 'vue-router'

Axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props: {
    list_id: String
  },
  setup(props) {
    const listId = props.list_id
    const title = ref('')
    const memo = ref('')
    const router = useRouter()

    // create new card
    const createCard = async () => {
      await Axios.post('/api/v1/lists/' + listId + '/cards', {
        title: title.value,
        memo: memo.value
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
      listId, title, memo, createCard
    }
  },
}
</script>
