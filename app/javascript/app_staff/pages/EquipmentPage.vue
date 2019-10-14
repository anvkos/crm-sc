<template lang="pug">
  q-page
    div.row
      h4.q-mb-md.q-mt-sm Equipment
    div.row
      div.col-8
        equipment-list(:items="equipmentItems")
      div.col-4
        equipment-form
    router-view
</template>

<script>
import { QPage } from 'quasar';
import { mapGetters, mapActions } from 'vuex';
import EquipmentList from 'staffApp/components/equipments/EquipmentList';
import EquipmentForm from 'staffApp/components/equipments/EquipmentForm';
import Api from 'staffApi';

export default {
  components: {
    EquipmentForm,
    EquipmentList,
  },

  computed: {
    ...mapGetters({
      equipmentItems: 'equipments/equipments',
    }),
  },

  created() {
    this.fetchAll();
  },

  methods: {
    ...mapActions({
      fetchAll: 'equipments/fetchAll',
    }),
  },
};
</script>
