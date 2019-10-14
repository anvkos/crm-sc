import * as types from './mutation-types';

export default {
  [types.SET_ORGANIZATIONS](state, organizations) {
    state.organizations = organizations;
  },

  [types.SET_ORGANIZATION](state, organization) {
    state.organization = organization;
  },

  [types.ADD_ORGANIZATION](state, organization) {
    state.organizations.push(organization);
  },

  [types.UPDATE_ORGANIZATION](state, organization) {
    const index = state.organizations.findIndex(item => item.id === organization.id);
    state.organizations[index] = Object.assign({}, organization);
  },

  [types.DESTROY_ORGANIZATION](state, id) {
    const index = state.organizations.findIndex(item => item.id === id);
    state.organizations.splice(index, 1);
  },

  [types.SET_ORGANIZATION_CLIENTS](state, clients) {
    state.organizationClients = clients;
  },

  [types.ADD_ORGANIZATION_CLIENT](state, client) {
    state.organizationClients.push(client);
  },
};
