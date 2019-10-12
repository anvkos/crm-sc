import { SET_MESSAGE, CLEAR_MESSAGE } from './mutation-types';

export const flashMessage = ({ commit }, message) => {
  commit(SET_MESSAGE, message);
  setTimeout(() => {
    commit(CLEAR_MESSAGE);
  }, 3000);
};

export default {
  flashMessage,
};
