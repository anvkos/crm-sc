import { SET_STAFFS, SET_STAFF } from './mutation-types';

export default {
  [SET_STAFFS](state, staffs) {
    state.staffs = staffs;
  },

  [SET_STAFF](state, staff) {
    state.staff = staff;
  },
};
