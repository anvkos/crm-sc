import api from 'staffApi';
import { SET_STAFFS, SET_STAFF, UPDATE_STAFF } from './mutation-types';

export const fetchStaffs = ({ commit }) => {
  api.staffs.fetchAll().then(data => {
    commit(SET_STAFFS, data);
  });
};

export const fetchStaff = ({ commit }, id) => {
  api.staffs.fetch(id).then(data => {
    commit(SET_STAFF, data);
  });
};

export const update = ({ commit }, { id, params }) => {
  api.staffs.update(id, params).then(data => {
    commit(SET_STAFF, data);
    commit(UPDATE_STAFF, data);
  });
};

export default {
  fetchStaffs,
  fetchStaff,
  update,
};
