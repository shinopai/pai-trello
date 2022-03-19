<template>
  <div class='w-2/3 mx-auto text-center mt-10'>
  <div class="container">
    <div class="cardContents">
      <div class="cardContents_title my-3">
        <div class="text-2xl font-bold">タイトル</div>
        <h2 class="text-lg">{{ card.title }}</h2>
      </div>
      <div class="cardContents_memo my-3">
        <div class="text-2xl font-bold">メモ</div>
        <div class="text-lg">{{ card.memo }}</div>
      </div>
      <div class="cardContents_listStatus my-3">
        <div class="text-2xl font-bold">リスト名</div>
        <div class="text-lg">{{ cardList }}</div>
      </div>
      <div class="cardContents_btnArea mt-10">
        <router-link :to="{ name: 'edit-card-form',  params: { 'id' : card.id } }" class="inline-block px-6 py-2.5 bg-blue-600 text-white font-medium text-md leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out">編集</router-link>
        <br>
        <button type="button" class="inline-block px-6 py-2 text-red-600 font-medium text-lg leading-tight uppercase rounded hover:underline mt-3" @click="deleteCard">削除する</button>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import { ref } from 'vue'
import Axios from 'axios'
import { useRouter } from 'vue-router'

export default {
  props: {
    id: String
  },
  setup(props) {
    const cardId = props.id
    const card = ref({})
    const cardList = ref('')
    const router = useRouter()

    // get card detail
    const getCardDetail = async () => {
      await Axios.get('/api/v1/cards/' + cardId)
                 .then( res => {
                   card.value = res.data.card
                   cardList.value = res.data.card_list
                 })
                 .catch( err => {
                   console.log(err.response.data.message)
                 })
    }

    // delete card
    const deleteCard = async () => {
      if(confirm('削除して宜しいですか？')){
        await Axios.delete('/api/v1/cards/' + cardId)
                   .then( res => {
                     console.log(res.data)
                     goHome()
                   })
                   .catch( err => {
                     console.log(err.response.data.message)
                   })
      }
    }

    // go to home
    const goHome = () => {
      router.push('/')
    }

    getCardDetail()

    return {
      card, cardList, deleteCard
    }
  },
}
</script>
