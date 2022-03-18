<template>
  <div class="p-5 w-11/12 mx-auto">
    <span>{{ currentUser.name }}さん</span>

    <!-- lists -->
    <List />
    </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue'
import { useStore } from 'vuex'
import List from './list/List.vue'
import Axios from 'axios'

export default {
  components: {
    List
  },
  setup() {
    const store= useStore()

    // delete list
    const deleteList = async (listId) => {
      if(confirm('本当に削除して宜しいですか？')){
        await Axios.delete('/api/v1/lists/' + listId)
                  .then( res => {
                     console.log(res.data.message)
                     store.dispatch('getAllLists', store.state.currentUser.id)
                   })
                   .catch( err => {
                     console.log(err.response.data.message)
                   })
      }
    }

    // show edit form
    const showEditForm = (listId) => {
      let editForm = document.getElementById('edit-form' + listId)
      editForm.classList.remove('hidden')
      document.getElementById('buttons' + listId).classList.remove('hidden')
      document.getElementById('list-title' + listId).classList.add('hidden')
    }

    // cancel edit
    const cancelEdit = (listId) => {
      document.getElementById('edit-form' + listId).classList.add('hidden')
      document.getElementById('buttons' + listId).classList.add('hidden')
      document.getElementById('list-title' + listId).classList.remove('hidden')
    }

    // init edit form
    const initForm = (listId) => {
      document.getElementById('edit-form' + listId).classList.add('hidden')
      document.getElementById('buttons' + listId).classList.add('hidden')
      document.getElementById('list-title' + listId).classList.remove('hidden')
      store.dispatch('getAllLists', store.state.currentUser.id)
    }

    // update list
    const updateList = async (listId, listTitle) => {
      await Axios.patch('/api/v1/users/' + store.state.currentUser.id + '/lists/' + listId, {
        title: listTitle
      })
                 .then( res => {
                   console.log(res.data)
                   initForm(listId)
                 })
                 .catch( err => {
                   console.log(err.response.data.message)
                 })
    }

    onMounted( async () => {
      await store.dispatch('getCurrentUser')
    })

    return {
      currentUser: computed(() => store.state.currentUser)
    }
  },
}
</script>

<style>
  .plus-card-button::after{
    content: ' カードを追加';
  }
</style>
