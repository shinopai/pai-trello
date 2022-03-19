<template>
<div class="min-h-screen bg-gray-100 dark:bg-gray-900 py-2 flex flex-col justify-start sm:py-12 rounded mt-5">
  <div class="grid lg:grid-cols-4 md:grid-cols-3 sm:grid-cols-2 grid-cols-1 gap-4 px-4">
    <!-- SMALL CARD ROUNDED -->
    <template v-if="allLists.length > 0">
      <div v-for="list in allLists" :key="list" class="border-indigo-100 bg-opacity-95 border-opacity-60 | p-4 border-solid rounded-3xl border-2 ">
            <div class="flex justify-start cursor-pointer">
    <div class="bg-gray-100 w-full">
      <div class="flex justify-between w-full">
        <span class="text-gray-900 dark:text-gray-300 font-semibold">
        <input type="text" v-model="list.title" class="hidden py-1 px-0.5" :id="`edit-form${ list.id }`">
        <div :id="`buttons${ list.id }`" class="hidden mt-2">
        <button class="inline-block px-1 py-1.5 bg-red-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-red-700 hover:shadow-lg focus:bg-red-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-red-800 active:shadow-lg transition duration-150 ease-in-out" @click="cancelEdit(list.id)">キャンセル</button>
        <button class="inline-block px-1 py-1.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out ml-1" @click="updateList(list.id, list.title)">更新</button>
        </div>
          <span :id="`list-title${ list.id }`">{{ list.title }}</span>
          </span>
        <span class="text-black dark:text-gray-100 text-justify font-semibold flex"><span><Delete @click="deleteList(list.id)" /></span><span><Pencil @click="showEditForm(list.id)" /></span></span>
      </div>
    </div>
    </div>

    <!-- card lists -->
    <Card :listId="list.id" />

      <span class="ml-2 cursor-pointer"><router-link :to="{ name: 'create-card-form',  params: { 'list_id' : list.id } }"><Plus class="inline mb-1 plus-card-button flex" /></router-link></span>

    </div>
    </template>
        <template v-else>
    <p>リストはありません</p>
    </template>
  </div>
  </div>
</template>

<script>
import { onMounted, computed } from 'vue'
import { useStore } from 'vuex'
import Delete from 'vue-material-design-icons/Delete.vue'
import Pencil from 'vue-material-design-icons/Pencil.vue'
import Plus from 'vue-material-design-icons/Plus.vue'
import Card from '../card/Card.vue'
import Axios from 'axios'

export default {
  components: {
    Delete, Pencil, Plus, Card
  },
  setup() {
    const store= useStore()

    // delete list
    const deleteList = async (listId) => {
      if(confirm('削除して宜しいですか？')){
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
      store.dispatch('getAllLists', store.state.currentUser.id)
    })

    return {
      allLists: computed(() => store.state.allLists),
      deleteList, showEditForm, cancelEdit, updateList
    }
  },
}
</script>

<style>
  .plus-card-button::after{
    content: ' カードを追加';
  }
</style>
