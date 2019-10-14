import api from 'staffApi';
import {
  SET_ORGANIZATIONS,
  SET_ORGANIZATION,
  ADD_ORGANIZATION,
  UPDATE_ORGANIZATION,
  DESTROY_ORGANIZATION,
  SET_ORGANIZATION_CLIENTS,
  ADD_ORGANIZATION_CLIENT,
} from './mutation-types';

export const fetchAll = ({ commit }) => {
  api.organizations.fetchAll().then(data => {
    commit(SET_ORGANIZATIONS, data);
  });
};

export const fetchSingle = ({ commit }, id) => {
  api.organizations.fetch(id).then(data => {
    commit(SET_ORGANIZATION, data);
  });
};

export const create = ({ commit }, params) => {
  api.organizations.create(params).then(data => {
    commit(ADD_ORGANIZATION, data);
  });
};

export const update = ({ commit }, { id, params }) => {
  api.organizations.update(id, params).then(data => {
    commit(SET_ORGANIZATION, data);
    commit(UPDATE_ORGANIZATION, data);
  });
};

export const destroy = ({ commit }, { id }) => {
  api.organizations.destroy(id).then(() => {
    commit(DESTROY_ORGANIZATION, id);
  });
};

export const fetchClients = ({ commit }, id) => {
  api.organizations.fetchClients(id, ).then(data => {
    commit(SET_ORGANIZATION_CLIENTS, data);
  });
};

export const addClient = ({ commit }, { id, client }) => {
  api.organizations.addClient(id, client).then(data => {
    commit(ADD_ORGANIZATION_CLIENT, data);
  });
};

export default {
  fetchAll,
  fetchSingle,
  create,
  update,
  destroy,
  fetchClients,
  addClient,
};
