import api from 'staffApi';
import {
  SET_ORGANIZATIONS,
  ADD_ORGANIZATION,
  DESTROY_ORGANIZATION,
} from './mutation-types';

export const fetchAll = ({ commit }) => {
  api.organizations.fetchAll().then(data => {
    commit(SET_ORGANIZATIONS, data);
  });
};

export const create = ({ commit }, params) => {
  api.organizations.create(params).then(data => {
    commit(ADD_ORGANIZATION, data);
  });
};

export const destroy = ({ commit }, { id }) => {
  api.organizations.destroy(id).then(() => {
    commit(DESTROY_ORGANIZATION, id);
  });
}

export default {
  fetchAll,
  create,
  destroy,
};
