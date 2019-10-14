import api from 'staffApi';
import {
  SET_EQUIPMENTS,
  SET_EQUIPMENT,
  UPDATE_EQUIPMENT,
  ADD_EQUIPMENT,
  SET_EQUIPMENT_TYPES,
} from './mutation-types';

export const fetchAll = ({ commit }) => {
  api.equipments.fetchAll().then(data => {
    commit(SET_EQUIPMENTS, data);
  });
};

export const fetchSingle = ({ commit }, id) => {
  api.equipments.fetch(id).then(data => {
    commit(SET_EQUIPMENT, data);
  });
};

export const create = ({ commit }, params) => {
  api.equipments.create(params).then(data => {
    commit(ADD_EQUIPMENT, data);
  });
};

export const update = ({ commit }, { id, params }) => {
  api.equipments.update(id, params).then(data => {
    commit(SET_EQUIPMENT, data);
    commit(UPDATE_EQUIPMENT, data);
  });
};

export const fetchTypes = ({ commit }, params) => {
  api.equipments.fetchTypes(params).then(data => {
    commit(SET_EQUIPMENT_TYPES, data);
  });
};

export default {
  fetchAll,
  fetchSingle,
  create,
  update,
  fetchTypes,
};
