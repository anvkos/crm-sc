import * as types from './mutation-types';

export default {
  [types.SET_EQUIPMENTS](state, equipments) {
    state.equipments = equipments;
  },

  [types.SET_EQUIPMENT](state, equipment) {
    state.equipment = equipment;
  },

  [types.ADD_EQUIPMENT](state, equipment) {
    state.equipments.push(equipment);
  },

  [types.UPDATE_EQUIPMENT](state, equipment) {
    const index = state.equipments.findIndex(item => item.id === equipment.id);
    state.equipments[index] = Object.assign({}, equipment);
  },

  [types.SET_EQUIPMENT_TYPES](state, types) {
    state.types = types;
  },
};
