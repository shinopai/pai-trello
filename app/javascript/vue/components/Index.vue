<template>
  <div class="p-5 w-11/12 mx-auto">
    <span>{{ currentUser.name }}さん</span>

    <!-- lists -->
    <List />
    </div>
</template>

<script>
import { onMounted, computed } from 'vue'
import { useStore } from 'vuex'
import List from './list/List.vue'

export default {
  components: {
    List
  },
  setup() {
    const store= useStore()

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
