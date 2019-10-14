import * as types from './mutation-types';

export default {
  [types.SET_STAFFS](state, staffs) {
    state.staffs = staffs;
  },

  [types.SET_STAFF](state, staff) {
    state.staff = staff;
  },

  [types.UPDATE_STAFF](state, staff) {
    const index = state.staffs.findIndex(item => item.id === staff.id);
    state.staffs[index] = Object.assign({}, staff);
  },
};
