import * as types from './mutation-types';

export default {
  [types.SET_CLIENTS](state, clients) {
    state.clients = clients;
  },

  [types.SET_CLIENT](state, client) {
    state.client = client;
  },

  [types.ADD_CLIENT](state, client) {
    state.clients.push(client);
  },

  [types.UPDATE_CLIENT](state, client) {
    const index = state.clients.findIndex(item => item.id === client.id);
    state.clients[index] = Object.assign({}, client);
  },

  [types.SET_CLIENT_ORGANIZATIONS](state, organizations) {
    state.clientOrganizations = organizations;
  },

  [types.ADD_CLIENT_ORGANIZATION](state, organization) {
    state.clientOrganizations.push(organization);
  },
};
