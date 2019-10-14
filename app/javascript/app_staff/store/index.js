import Vue from 'vue';
import Vuex from 'vuex';
import state from './state';
import getters from './getters';
import mutations from './mutations';
import actions from './actions';
import clients from './clients';
import equipments from './equipments';
import organizations from './organizations';
import staffs from './staffs';

Vue.use(Vuex);

const debug = process.env.NODE_ENV !== 'production';

export default new Vuex.Store({
  state,
  getters,
  mutations,
  actions,

  modules: {
    clients,
    equipments,
    organizations,
    staffs,
  },

  strict: debug,
});
