import {
  createStore
} from 'vuex'
import Axios
from 'axios'

const store = createStore({
  state() {
    return {
      currentUser: {},
      allLists: {},
      list: {}
    }
  },
  mutations: {
    setUser(state, data) {
      state.currentUser = data
    },
    setLists(state, data) {
      state.allLists = data
    },
    setList(state, data) {
      state.list = data
    }
  },
  actions: {
    async getCurrentUser(context) {
      await Axios.get('/api/v1/user')
        .then(res => {
          context.commit('setUser', res.data)
        })
        .catch(err => {
          console.log(err.response.data.message)
        })
    },
    async getAllLists(context, userId) {
      await Axios.get('/api/v1/users/' + userId + '/lists')
        .then(res => {
          context.commit('setLists', res.data)
          console.log(res.data);
        })
        .catch(err => {
          console.log(err.response.data.message)
        })
    },
    async getList(context, listId) {
      await Axios.get('/api/v1/lists/' + listId)
        .then(res => {
          context.commit('setList', res.data)
          console.log(res.data);
        })
        .catch(err => {
          console.log(err.response.data.message)
        })
    },
  }
})


export default store
