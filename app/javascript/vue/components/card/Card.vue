<template>
      <div class="flex items-center justify-center mt-2 py-5">
  <div class="container">
      <div class="flex justify-center">
            <div class="bg-white w-11/12">
                <ul class="divide-y divide-gray-300">
                  <template v-if="cards.length > 0">
                    <li v-for="card in cards" :key="card" class="p-2 hover:bg-gray-50 cursor-pointer"><router-link :to="{ name: 'card-detail',  params: { 'id' : card.id } }" class="block">{{ card.title }}</router-link></li>
                  </template>
                  <template v-else>
                    <li class="p-2 hover:bg-gray-50 cursor-pointer">カードはありません</li>
                  </template>
                </ul>
            </div>
        </div>
  </div>
</div>
</template>

<script>
import { ref, onMounted } from 'vue'
import Axios from 'axios'

export default {
  props: {
    listId: Number
  },
  setup(props) {
    const listId = props.listId
    const cards = ref({})

    // get cards each list
    const getCards = async () => {
      await Axios.get('/api/v1/lists/' + listId + '/cards')
                 .then( res => {
                   cards.value = res.data
                 })
                 .catch( err => {
                   console.log(err.response.data)
                 })
    }

    onMounted(() => {
      getCards()
    })

    return {
      cards
    }
  },
}
</script>
