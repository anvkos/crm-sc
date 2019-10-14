<template lang="pug">
  app-modal(:title="'Edit'")
    .form-container
      equipment-form(v-if="equipment" :equipment="equipment" @equipment-updated="onEquipmentUpdated")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import AppModal from 'staffApp/components/AppModal';
import EquipmentForm from 'staffApp/components/equipments/EquipmentForm';

export default {
  components: {
    AppModal,
    EquipmentForm,
  },

  computed: {
    ...mapGetters({
      equipment: 'equipments/equipment',
    }),

    id() {
      return this.$route.params.id;
    }
  },

  created() {
    this.fetchEquipment(this.id);
  },

  methods: {
    ...mapActions({
      fetchEquipment: 'equipments/fetchSingle',
    }),

    onEquipmentUpdated() {
      this.$router.push({ name: 'equipments.index' });
    },
  },
};
</script>

<style lang="styl" scoped>
  .form-container {
    width: 400px;
  }
</style>
