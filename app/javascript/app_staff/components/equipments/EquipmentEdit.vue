<template lang="pug">
  app-modal(:title="'Edit'")
    .form-container
      equipment-form(v-if="equipment" :equipment="equipment" @equipment-updated="onEquipmentUpdated")
</template>

<script>
import Api from 'staffApi';
import AppModal from 'staffApp/components/AppModal';
import EquipmentForm from 'staffApp/components/equipments/EquipmentForm';

export default {
  components: {
    AppModal,
    EquipmentForm,
  },

  data() {
    return {
      equipment: null,
    };
  },

  computed: {
    id() {
      return this.$route.params.id;
    }
  },

  created() {
    this.fetchEquipment();
  },

  methods: {
    fetchEquipment() {
      Api.equipments.fetch(this.id).then(data => {
        this.equipment = data;
      });
    },

    onEquipmentUpdated() {
      this.$router.go(-1);
    }
  },
};
</script>

<style lang="styl" scoped>
  .form-container {
    width: 400px;
  }
</style>
