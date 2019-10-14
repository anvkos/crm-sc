import * as types from './mutation-types';

export default {
  [types.SET_ORGANIZATIONS](state, organizations) {
    state.organizations = organizations;
  },

  [types.ADD_ORGANIZATION](state, organization) {
    state.organizations.push(organization);
  },

  [types.DESTROY_ORGANIZATION](state, id) {
    const index = state.organizations.findIndex(item => item.id === id);
    state.organizations.splice(index, 1);
  },
};
