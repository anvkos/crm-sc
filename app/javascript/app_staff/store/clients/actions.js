import api from 'staffApi';
import {
  SET_CLIENTS,
  SET_CLIENT,
  UPDATE_CLIENT,
  ADD_CLIENT,
  SET_CLIENT_ORGANIZATIONS,
  ADD_CLIENT_ORGANIZATION,

} from './mutation-types';

export const fetchAll = ({ commit }) => {
  api.clients.fetchAll().then(data => {
    commit(SET_CLIENTS, data);
  });
};

export const fetchSingle = ({ commit }, id) => {
  api.clients.fetch(id).then(data => {
    commit(SET_CLIENT, data);
  });
};

export const create = ({ commit }, params) => {
  api.clients.create(params).then(data => {
    commit(ADD_CLIENT, data);
  });
};

export const update = ({ commit }, { id, params }) => {
  api.clients.update(id, params).then(data => {
    commit(SET_CLIENT, data);
    commit(UPDATE_CLIENT, data);
  });
};

export const fetchOrganizations = ({ commit }, id) => {
  api.clients.fetchOrganizations(id, ).then(data => {
    commit(SET_CLIENT_ORGANIZATIONS, data);
  });
};

export const addOrganization = ({ commit }, { id, organization }) => {
  api.clients.addOrganization(id, organization).then(data => {
    commit(ADD_CLIENT_ORGANIZATION, data);
  });
};

export default {
  fetchAll,
  fetchSingle,
  create,
  update,
  fetchOrganizations,
  addOrganization,
};
