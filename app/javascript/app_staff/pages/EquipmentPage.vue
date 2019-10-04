<template lang="pug">
  QPage
    div.row
      h4.q-mb-md.q-mt-sm Equipment
    div.row
      div.col-8
        EquipmentList(:items="equipmentItems")
      div.col-4
</template>

<script>
import { QPage } from 'quasar';
import EquipmentList from 'staffApp/components/equipments/EquipmentList';
import Api from 'staffApi';

export default {
  components: {
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
  },
};
</script>
