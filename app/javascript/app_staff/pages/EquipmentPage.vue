<template lang="pug">
  q-page
    div.row
      h4.q-mb-md.q-mt-sm Equipment
    div.row
      div.col-8
        equipment-list(:items="equipmentItems")
      div.col-4
        equipment-form(@equipment-created="onEquipmentCreated")
    router-view
</template>

<script>
import { QPage } from 'quasar';
import EquipmentList from 'staffApp/components/equipments/EquipmentList';
import EquipmentForm from 'staffApp/components/equipments/EquipmentForm';
import Api from 'staffApi';

export default {
  components: {
    EquipmentForm,
    EquipmentList,
  },

  data() {
    return {
      equipmentItems: [],
    };
  },

created() {
    this.fetchAll();
  },

  methods: {
    fetchAll() {
      Api.equipments.fetchAll().then(data => {
        this.equipmentItems = data;
      });
    },

    onEquipmentCreated(equipment) {
      this.equipmentItems.push(equipment);
    },
  },
};
</script>
