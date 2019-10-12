import { SET_MESSAGE, CLEAR_MESSAGE } from './mutation-types';

export default {
  [SET_MESSAGE](state, message) {
    state.message = message;
  },

  [CLEAR_MESSAGE](state) {
    state.message = null;
  },
};
